import 'dart:io';

import 'package:flutter/material.dart';

import 'app_update_service.dart';

class UpdateGate extends StatefulWidget {
  const UpdateGate({super.key, required this.child});

  final Widget child;

  @override
  State<UpdateGate> createState() => _UpdateGateState();
}

class _UpdateGateState extends State<UpdateGate> {
  final AppUpdateService _service = AppUpdateService();
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  Future<void> _check() async {
    if (_checked || !Platform.isAndroid) return;
    _checked = true;

    try {
      final update = await _service.checkForUpdate();
      if (!mounted || update == null) return;
      await _showUpdateDialog(update);
    } catch (_) {
      // Update checks should never block normal app startup.
    }
  }

  Future<void> _showUpdateDialog(AppUpdateInfo update) {
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
                _downloadAndInstall(update);
              },
              icon: const Icon(Icons.download_rounded),
              label: const Text('Update now'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _downloadAndInstall(AppUpdateInfo update) async {
    final progress = ValueNotifier<double>(0);

    if (mounted) {
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
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
      await _service.openInstaller(path);
    } catch (error) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).maybePop();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Update failed: $error'),
              behavior: SnackBarBehavior.floating,
            ),
          );
      }
    } finally {
      progress.dispose();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
