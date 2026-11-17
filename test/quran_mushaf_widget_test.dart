import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nada_zikrakanm/services/quran_service.dart';
import 'package:nada_zikrakanm/widgets/quran_mushaf_page_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const sampleAyahsPage1 = [
    QuranAyah(surah: 1, ayah: 1, text: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', page: 1, juz: 1),
    QuranAyah(surah: 1, ayah: 2, text: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ', page: 1, juz: 1),
    QuranAyah(surah: 1, ayah: 3, text: 'ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', page: 1, juz: 1),
    QuranAyah(surah: 1, ayah: 4, text: 'مَٰلِكِ يَوْمِ ٱلدِّينِ', page: 1, juz: 1),
    QuranAyah(surah: 1, ayah: 5, text: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ', page: 1, juz: 1),
    QuranAyah(surah: 1, ayah: 6, text: 'ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ', page: 1, juz: 1),
    QuranAyah(surah: 1, ayah: 7, text: 'صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ', page: 1, juz: 1),
  ];

  const sampleAyahsDensePage = [
    QuranAyah(surah: 2, ayah: 142, text: 'سَيَقُولُ ٱلسُّفَهَآءُ مِنَ ٱلنَّاسِ مَا وَلَّىٰهُمْ عَن قِبْلَتِهِمُ ٱلَّتِى كَانُوا۟ عَلَيْهَا', page: 22, juz: 2),
    QuranAyah(surah: 2, ayah: 143, text: 'وَكَذَٰلِكَ جَعَلْنَٰكُمْ أُمَّةًۭ وَسَطًۭا لِّتَكُونُوا۟ شُهَدَآءَ عَلَى ٱلنَّاسِ وَيَكُونَ ٱلرَّسُولُ عَلَيْكُمْ شَهِيدًۭا وَمَا جَعَلْنَا ٱلْقِبْلَةَ ٱلَّتِى كُنتَ عَلَيْهَآ إِلَّا لِنَعْلَمَ مَن يَتَّبِعُ ٱلرَّسُولَ مِمَّن يَنقَلِبُ عَلَىٰ عَقِبَيْهِ', page: 22, juz: 2),
    QuranAyah(surah: 2, ayah: 144, text: 'قَدْ نَرَىٰ تَقَلُّبَ وَجْهِكَ فِى ٱلسَّمَآءِ فَلَنُوَلِّيَنَّكَ قِبْلَةًۭ تَرْضَىٰهَا فَوَلِّ وَجْهَكَ شَطْرَ ٱلْمَسْجِدِ ٱلْحَرَامِ وَحَيْثُ مَا كُنتُمْ فَوَلُّوا۟ وُجُوهَكُمْ شَطْرَهُۥ', page: 22, juz: 2),
    QuranAyah(surah: 2, ayah: 145, text: 'وَلَئِنْ أَتَيْتَ ٱلَّذِينَ أُوتُوا۟ ٱلْكِتَٰبَ بِكُلِّ ءَايَةٍۢ مَّا تَبِعُوا۟ قِبْلَتَكَ وَمَآ أَنتَ بِتَابِعٍۢ قِبْلَتَهُمْ وَمَا بَعْضُهُم بِتَابِعٍۢ قِبْلَةَ بَعْضٍۢ', page: 22, juz: 2),
  ];

  QuranSurahMeta? getSurahMeta(int num) {
    if (num == 1) {
      return QuranSurahMeta(
        number: 1,
        arabicName: 'الفاتحة',
        englishName: 'Al-Fatiha',
        englishNameTranslation: 'The Opening',
        kurdishName: 'فاتيحە',
        numberOfAyahs: 7,
        revelationType: 'Meccan',
      );
    }
    return QuranSurahMeta(
      number: 2,
      arabicName: 'البقرة',
      englishName: 'Al-Baqarah',
      englishNameTranslation: 'The Cow',
      kurdishName: 'بەقەرە',
      numberOfAyahs: 286,
      revelationType: 'Medinan',
    );
  }

  group('QuranMushafPageWidget & MushafBottomNavigationBar Tests', () {
    testWidgets('MushafBottomNavigationBar renders sleek compact bar and responds to taps', (tester) async {
      bool nextTapped = false;
      bool prevTapped = false;
      bool jumpTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MushafBottomNavigationBar(
              currentPage: 5,
              totalPages: 604,
              language: 'ar',
              onNextPage: () => nextTapped = true,
              onPreviousPage: () => prevTapped = true,
              onOpenJumpSheet: () => jumpTapped = true,
            ),
          ),
        ),
      );

      // Verify page number display
      expect(find.textContaining('٥'), findsWidgets);

      // Verify Next and Prev buttons exist and are tappable
      final nextFinder = find.text('التالي');
      final prevFinder = find.text('السابق');
      expect(nextFinder, findsOneWidget);
      expect(prevFinder, findsOneWidget);

      await tester.tap(nextFinder);
      expect(nextTapped, isTrue);

      await tester.tap(prevFinder);
      expect(prevTapped, isTrue);

      await tester.tap(find.byIcon(Icons.auto_stories_rounded));
      expect(jumpTapped, isTrue);
    });

    testWidgets('QuranMushafPageWidget renders Page 1 with ayahs starting at top and no SingleChildScrollView', (tester) async {
      bool jumpTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 390,
              height: 700,
              child: QuranMushafPageWidget(
                pageNumber: 1,
                ayahs: sampleAyahsPage1,
                getSurahMeta: getSurahMeta,
                highlightedSurahNumber: null,
                highlightedAyahNumber: null,
                bookmarkedAyahs: const {},
                onAyahTap: (_) {},
                onOpenJumpSheet: () => jumpTapped = true,
                isRtl: true,
                language: 'ar',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // No SingleChildScrollView should be used (pages need no scroll)
      expect(find.byType(SingleChildScrollView), findsNothing);

      // Verify page medallion
      expect(find.text('﴿ ١ ﴾'), findsOneWidget);

      // Verify Surah title is present (in top header bar and in Surah banner)
      expect(find.text('سُورَةُ الفاتحة'), findsNWidgets(2));

      // Verify tap on page medallion opens jump sheet
      await tester.tap(find.text('﴿ ١ ﴾'));
      expect(jumpTapped, isTrue);
    });

    testWidgets('QuranMushafPageWidget renders dense page within small screen bounds without overflow', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 560));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              height: 560,
              child: QuranMushafPageWidget(
                pageNumber: 22,
                ayahs: sampleAyahsDensePage,
                getSurahMeta: getSurahMeta,
                highlightedSurahNumber: null,
                highlightedAyahNumber: null,
                bookmarkedAyahs: const {},
                onAyahTap: (_) {},
                isRtl: true,
                language: 'ku',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Ensure no flutter overflow errors occurred
      expect(tester.takeException(), isNull);

      // Verify page number
      expect(find.text('﴿ ٢٢ ﴾'), findsOneWidget);

      // Restore screen size
      await tester.binding.setSurfaceSize(null);
    });
  });
}
