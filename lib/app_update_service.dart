import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class AppUpdateInfo {
  const AppUpdateInfo({
    required this.buildNumber,
    required this.tag,
    required this.downloadUrl,
    required this.notes,
  });

  final int buildNumber;
  final String tag;
  final String downloadUrl;
  final String notes;
}

class AppUpdateService {
  static const _latestReleaseApi =
      'https://api.github.com/repos/fahimakhtar0103-ui/Fashion-Ai-App/releases/latest';
  static const _apkAssetName = 'fashion-ai-app.apk';

  Future<AppUpdateInfo?> checkForUpdate() async {
    if (!Platform.isAndroid) return null;

    final response = await http.get(
      Uri.parse(_latestReleaseApi),
      headers: const {
        'Accept': 'application/vnd.github+json',
        'User-Agent': 'FashionAI-App',
      },
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final tag = (data['tag_name'] as String?) ?? '';
    final remoteBuild = _buildFromTag(tag);
    if (remoteBuild == null) return null;

    final packageInfo = await PackageInfo.fromPlatform();
    final localBuild = int.tryParse(packageInfo.buildNumber) ?? 0;
    if (remoteBuild <= localBuild) return null;

    final assets = (data['assets'] as List<dynamic>? ?? const []);
    Map<String, dynamic>? apk;
    for (final asset in assets) {
      final map = asset as Map<String, dynamic>;
      if (map['name'] == _apkAssetName) {
        apk = map;
        break;
      }
    }

    final downloadUrl = apk?['browser_download_url'] as String?;
    if (downloadUrl == null || downloadUrl.isEmpty) return null;

    return AppUpdateInfo(
      buildNumber: remoteBuild,
      tag: tag,
      downloadUrl: downloadUrl,
      notes: (data['body'] as String?)?.trim().isNotEmpty == true
          ? (data['body'] as String).trim()
          : 'A newer Fashion AI build is ready.',
    );
  }

  int? _buildFromTag(String tag) {
    final match = RegExp(r'(\d+)$').firstMatch(tag);
    return match == null ? null : int.tryParse(match.group(1)!);
  }

  Future<String> downloadApk(
    AppUpdateInfo update, {
    required void Function(double progress) onProgress,
  }) async {
    final request = http.Request('GET', Uri.parse(update.downloadUrl));
    request.headers['User-Agent'] = 'FashionAI-App';
    final response = await request.send();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('APK download failed (' + response.statusCode.toString() + ')');
    }

    final directory = await getTemporaryDirectory();
    final file = File(directory.path + '/fashion-ai-app-update.apk');
    final sink = file.openWrite();
    var received = 0;
    final total = response.contentLength ?? -1;

    try {
      await for (final chunk in response.stream) {
        received += chunk.length;
        sink.add(chunk);
        if (total > 0) {
          onProgress((received / total).clamp(0, 1));
        }
      }
    } finally {
      await sink.close();
    }

    onProgress(1);
    return file.path;
  }

  Future<void> openInstaller(String apkPath) async {
    final result = await OpenFilex.open(
      apkPath,
      type: 'application/vnd.android.package-archive',
    );
    if (result.type != ResultType.done) {
      throw StateError(result.message);
    }
  }
}
