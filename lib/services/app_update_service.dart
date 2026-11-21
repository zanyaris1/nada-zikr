import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_localizations.dart';
import '../widgets/app_theme.dart';
import 'storage_service.dart';

class AppUpdateService {
  // Remote URL where version.json is hosted (GitHub raw URL or your custom server)
  static const String _defaultVersionUrl =
      'https://raw.githubusercontent.com/zanyaris1/Nada_zikr/main/version.json';

  static const String _keyIgnoredVersion = 'ignored_update_version';
  static const String _keyLastPromptTime = 'last_update_prompt_timestamp';

  /// Minimum days to wait before prompting the user again if they tapped "Later"
  static const int _cooldownDays = 3;

  /// Check for optional update without blocking or disturbing the user
  static Future<void> checkForOptionalUpdate(
    BuildContext context, {
    String versionUrl = _defaultVersionUrl,
  }) async {
    try {
      // 1. Fetch remote version info with short timeout
      final uri = Uri.parse(versionUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 4));
      if (response.statusCode != 200) return;

      final Map<String, dynamic> data = jsonDecode(response.body);
      final String? latestVersion = data['latest_version'] as String?;
      if (latestVersion == null || latestVersion.isEmpty) return;

      // 2. Read local stored preferences
      final String? ignoredVersion =
          await StorageService.readSetting(_keyIgnoredVersion) as String?;
      if (ignoredVersion == latestVersion) {
        // User explicitly tapped "Don't show again" for this version
        return;
      }

      final dynamic lastPromptTimeRaw =
          await StorageService.readSetting(_keyLastPromptTime);
      if (lastPromptTimeRaw != null) {
        final int lastTimestamp = lastPromptTimeRaw is int
            ? lastPromptTimeRaw
            : int.tryParse(lastPromptTimeRaw.toString()) ?? 0;
        if (lastTimestamp > 0) {
          final lastDate = DateTime.fromMillisecondsSinceEpoch(lastTimestamp);
          if (DateTime.now().difference(lastDate).inDays < _cooldownDays) {
            // Cooldown active: do not disturb user yet
            return;
          }
        }
      }

      // 3. Compare with currently installed app version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      if (!_isVersionOlder(currentVersion, latestVersion)) {
        return;
      }

      if (!context.mounted) return;

      // 4. Update last prompt timestamp so it doesn't repeat for at least 3 days
      await StorageService.saveSetting(
        _keyLastPromptTime,
        DateTime.now().millisecondsSinceEpoch,
      );

      // 5. Determine store URL and localized release notes
      final String storeUrl = Platform.isAndroid
          ? (data['android_url'] ??
              'https://play.google.com/store/apps/details?id=com.nada.zikrakanm')
          : (data['ios_url'] ??
              'https://apps.apple.com/app/nada-zikr/id6738914800');

      final String lang = AppLocalizations.languageCode;
      String releaseNotes = '';
      if (lang == 'ar') {
        releaseNotes = data['release_notes_ar'] ??
            'تم إضافة تحسينات وإصلاحات جديدة للتطبيق لتجربة أفضل.';
      } else if (lang == 'en') {
        releaseNotes = data['release_notes_en'] ??
            'New updates and performance improvements for a better experience.';
      } else {
        // Kurdish (ku / kmr)
        releaseNotes = data['release_notes_ku'] ??
            'نوێکاری و چاکسازی نوێ بۆ ئەپەکە زیادکراوە بۆ ئەزموونێکی باشتر.';
      }

      // 6. Show the optional dialog
      if (!context.mounted) return;
      _showOptionalUpdateDialog(
        context: context,
        latestVersion: latestVersion,
        releaseNotes: releaseNotes,
        storeUrl: storeUrl,
      );
    } catch (e) {
      debugPrint('[AppUpdateService] Optional update check skipped: $e');
    }
  }

  /// Helper to compare semver versions like "1.0.0" vs "1.0.1"
  static bool _isVersionOlder(String current, String latest) {
    try {
      final List<int> cParts = current
          .split('+')
          .first
          .split('.')
          .map((e) => int.tryParse(e) ?? 0)
          .toList();
      final List<int> lParts = latest
          .split('+')
          .first
          .split('.')
          .map((e) => int.tryParse(e) ?? 0)
          .toList();

      for (int i = 0; i < lParts.length; i++) {
        final c = i < cParts.length ? cParts[i] : 0;
        if (lParts[i] > c) return true;
        if (lParts[i] < c) return false;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static void _showOptionalUpdateDialog({
    required BuildContext context,
    required String latestVersion,
    required String releaseNotes,
    required String storeUrl,
  }) {
    final palette = AppThemeController.instance.palette;
    final lang = AppLocalizations.languageCode;
    final isRtl = AppLocalizations.isRtl();

    final String title = lang == 'ar'
        ? 'تحديث جديد متوفر (v$latestVersion)'
        : lang == 'en'
            ? 'Update Available (v$latestVersion)'
            : 'وەشانی نوێ بەردەستە (v$latestVersion)';

    final String prompt = lang == 'ar'
        ? 'هل ترغب في تحديث التطبيق الآن؟'
        : lang == 'en'
            ? 'Would you like to update the app now?'
            : 'ئایا دەتەوێت ئێستا ئەپەکە نوێ بکەیتەوە؟';

    final String laterText = lang == 'ar'
        ? 'لاحقاً'
        : lang == 'en'
            ? 'Later'
            : 'دواتر';

    final String ignoreText = lang == 'ar'
        ? 'لا تذكرني بهذا الإصدار'
        : lang == 'en'
            ? "Don't ask again"
            : 'ئیتر نیشانم مەدە';

    final String updateText = lang == 'ar'
        ? 'تحديث الآن'
        : lang == 'en'
            ? 'Update'
            : 'نوێکردنەوە';

    showDialog(
      context: context,
      barrierDismissible: true, // User can simply tap outside to dismiss
      builder: (ctx) {
        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            backgroundColor: palette.panelColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: palette.panelBorderColor.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: palette.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.system_update_rounded,
                    color: palette.gold,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: palette.lightText,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  releaseNotes,
                  style: TextStyle(
                    color: palette.lightText.withValues(alpha: 0.9),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  prompt,
                  style: TextStyle(
                    color: palette.mutedText,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            actions: [
              // Option to completely ignore this update
              TextButton(
                onPressed: () async {
                  await StorageService.saveSetting(_keyIgnoredVersion, latestVersion);
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
                child: Text(
                  ignoreText,
                  style: TextStyle(
                    color: palette.mutedText,
                    fontSize: 12,
                  ),
                ),
              ),
              // Option to dismiss for now (remind again in 3 days)
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  laterText,
                  style: TextStyle(
                    color: palette.lightText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Update button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: palette.gold,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  final uri = Uri.parse(storeUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: Text(
                  updateText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

