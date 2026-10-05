import 'dart:io';

import 'package:flutter/material.dart';

import 'app_update_service.dart';

class AppUpdateUi {
  static final AppUpdateService _service = AppUpdateService();

  static Future<void> check(
    BuildContext context, {
    bool showUpToDate = false,
  }) async {
    if (!Platform.isAndroid) {
      if (showUpToDate && context.mounted) {
        _message(context, 'iPhone updates are handled through TestFlight.');
      }
      return;
    }

    try {
      final update = await _service.checkForUpdate();
      if (!context.mounted) return;

      if (update == null) {
        if (showUpToDate) {
          _message(context, 'You already have the latest Android build.');
        }
        return;
      }

      await _showUpdateDialog(context, update);
    } catch (_) {
      if (showUpToDate && context.mounted) {
        _message(context, 'Could not check for updates right now.');
      }
    }
  }

  static Future<void> _showUpdateDialog(
    BuildContext context,
    AppUpdateInfo update,
  ) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Row(
            children: [
              Icon(Icons.system_update_rounded),
              SizedBox(width: 10),
              Text('Update available'),
            ],
          ),
          content: Text(
            update.notes,
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Later'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _downloadAndInstall(context, update);
              },
              icon: const Icon(Icons.download_rounded),
              label: const Text('Update now'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _downloadAndInstall(
    BuildContext context,
    AppUpdateInfo update,
  ) async {
    final progress = ValueNotifier<double>(0);

    if (context.mounted) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: const Text('Downloading update'),
              content: ValueListenableBuilder<double>(
                valueListenable: progress,
                builder: (_, value, __) {
                  final percent = (value * 100).round();
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(value: value == 0 ? null : value),
                      const SizedBox(height: 12),
                      Text(value == 0 ? 'Starting…' : '$percent% downloaded'),
                    ],
                  );
                },
              ),
            ),
          );
        },
      );
    }

    try {
      final path = await _service.downloadApk(
        update,
        onProgress: (value) => progress.value = value,
      );

      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      await _service.openInstaller(path);
    } catch (error) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).maybePop();
        _message(context, 'Update failed: $error');
      }
    } finally {
      progress.dispose();
    }
  }

  static void _message(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class UpdateGate extends StatefulWidget {
  const UpdateGate({super.key, required this.child});

  final Widget child;

  @override
  State<UpdateGate> createState() => _UpdateGateState();
}

class _UpdateGateState extends State<UpdateGate> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  Future<void> _check() async {
    if (_checked) return;
    _checked = true;
    await AppUpdateUi.check(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
