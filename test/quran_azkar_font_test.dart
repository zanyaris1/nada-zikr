import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nada_zikrakanm/models/app_data.dart';
import 'package:nada_zikrakanm/models/azkar_model.dart';
import 'package:nada_zikrakanm/widgets/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  group('Quran Ayahs in Zikr section font & detection test', () {
    test('Ayat al-Kursi in sleep azkar is detected as Quran and has Quran title', () {
      final sleepList = AppData.sleepAzkar;
      final ayatKursi = sleepList.firstWhere((a) => a.arabic.contains('الْحَيُّ الْقَيُّومُ'));
      expect(ayatKursi.isQuranAyah, isTrue);
      expect(ayatKursi.getQuranTitle('ku'), contains('ئایەتی کورسی'));
      expect(ayatKursi.getQuranTitle('en'), contains('Ayat Al-Kursi'));
      expect(ayatKursi.getQuranTitle('ar'), contains('آيَةُ الكُرْسِيّ'));
    });

    test('Amanar-Rasul in sleep azkar is detected as Quran and has Quran title', () {
      final sleepList = AppData.sleepAzkar;
      final amanarRasul = sleepList.firstWhere((a) => a.arabic.contains('آمَنَ الرَّسُولُ'));
      expect(amanarRasul.isQuranAyah, isTrue);
      expect(amanarRasul.getQuranTitle('ku'), contains('کۆتایی سوورەتی بەقەرە'));
    });

    test('Non-Quran zikrs in sleep are NOT marked as Quran ayahs', () {
      final nonQuranZikr = Azkar(
        arabic: 'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي وَبِكَ أَرْفَعُهُ',
        translation: 'In Your name, my Lord, I lie down and in Your name I rise.',
        kurdishTranslation: 'بەناوی تۆوە پەروەردگارم...',
        repeat: 1,
        source: 'صحيح البخاري',
      );
      expect(nonQuranZikr.isQuranAyah, isFalse);
      expect(nonQuranZikr.getQuranTitle('ku'), isNull);
    });

    test('The 3 Quls (Ikhlas, Falaq, Nas) are detected as Quran ayahs', () {
      final ikhlas = Azkar(
        arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ۝ قُلْ هُوَ اللَّهُ أَحَدٌ',
        translation: '',
        kurdishTranslation: '',
        repeat: 3,
        source: 'سوورەتی ئیخڵاس [112: 1-4]',
      );
      final falaq = Azkar(
        arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ۝ قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ',
        translation: '',
        kurdishTranslation: '',
        repeat: 3,
        source: 'سوورەتی فەلەق [113: 1-5]',
      );
      final nas = Azkar(
        arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ۝ قُلْ أَعُوذُ بِرَبِّ النَّاسِ',
        translation: '',
        kurdishTranslation: '',
        repeat: 3,
        source: 'سوورەتی ناس [114: 1-6]',
      );

      expect(ikhlas.isQuranAyah, isTrue);
      expect(falaq.isQuranAyah, isTrue);
      expect(nas.isQuranAyah, isTrue);

      expect(ikhlas.getQuranTitle('ku'), contains('سوورەتی ئیخڵاس'));
      expect(falaq.getQuranTitle('ku'), contains('سوورەتی فەلەق'));
      expect(nas.getQuranTitle('ku'), contains('سوورەتی ناس'));
    });

    test('QuranAyahText style uses Scheherazade New with cv72 feature', () {
      final style = AppTheme.quranAyahText(fontSize: 26);
      expect(style.fontFamily, contains('Scheherazade'));
      expect(style.fontSize, 26);
      expect(style.fontFeatures, isNotEmpty);
      expect(style.fontFeatures!.any((f) => f.feature == 'cv72'), isTrue);
    });

    test('zikrText style uses Cairo font for non-Quran dhikr', () {
      final style = AppTheme.zikrText(fontSize: 24);
      expect(style.fontFamily, contains('Cairo'));
      expect(style.fontSize, 24);
    });
  });
}
