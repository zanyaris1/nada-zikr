import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/quran_service.dart';
import 'app_theme.dart';

/// Helper to convert standard integers to Eastern Arabic numerals (٠, ١, ٢, ٣...)
String toArabicDigits(int number) {
  const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number.toString().split('').map((c) {
    final idx = int.tryParse(c);
    return idx != null ? digits[idx] : c;
  }).join('');
}

/// Traditional Arabic Juz names for authentic Mushaf header
const List<String> kArabicJuzNames = [
  'الجُزْءُ الأَوَّلُ',
  'الجُزْءُ الثَّانِي',
  'الجُزْءُ الثَّالِثُ',
  'الجُزْءُ الرَّابِعُ',
  'الجُزْءُ الخَامِسُ',
  'الجُزْءُ السَّادِسُ',
  'الجُزْءُ السَّابِعُ',
  'الجُزْءُ الثَّامِنُ',
  'الجُزْءُ التَّاسِعُ',
  'الجُزْءُ العَاشِرُ',
  'الجُزْءُ الحَادِي عَشَرَ',
  'الجُزْءُ الثَّانِي عَشَرَ',
  'الجُزْءُ الثَّالِثَ عَشَرَ',
  'الجُزْءُ الرَّابِعَ عَشَرَ',
  'الجُزْءُ الخَامِسَ عَشَرَ',
  'الجُزْءُ السَّادِسَ عَشَرَ',
  'الجُزْءُ السَّابِعَ عَشَرَ',
  'الجُزْءُ الثَّامِنَ عَشَرَ',
  'الجُزْءُ التَّاسِعَ عَشَرَ',
  'الجُزْءُ العِشْرُونَ',
  'الجُزْءُ الحَادِي وَالعِشْرُونَ',
  'الجُزْءُ الثَّانِي وَالعِشْرُونَ',
  'الجُزْءُ الثَّالِثُ وَالعِشْرُونَ',
  'الجُزْءُ الرَّابِعُ وَالعِشْرُونَ',
  'الجُزْءُ الخَامِسُ وَالعِشْرُونَ',
  'الجُزْءُ السَّادِسُ وَالعِشْرُونَ',
  'الجُزْءُ السَّابِعُ وَالعِشْرُونَ',
  'الجُزْءُ الثَّامِنُ وَالعِشْرُونَ',
  'الجُزْءُ التَّاسِعُ وَالعِشْرُونَ',
  'الجُزْءُ الثَّلَاثُونَ',
];

String getArabicJuzTitle(int juz) {
  if (juz >= 1 && juz <= kArabicJuzNames.length) {
    return kArabicJuzNames[juz - 1];
  }
  return 'الجُزْءُ ${toArabicDigits(juz)}';
}

/// Authentic Islamic border frame painter for Real Madani Mushaf pages
class MushafFramePainter extends CustomPainter {
  final Color goldColor;
  final Color borderColor;

  MushafFramePainter({
    required this.goldColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // 1. Outer Border
    final outerPaint = Paint()
      ..color = goldColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4, 4, w - 8, h - 8),
      const Radius.circular(8),
    );
    canvas.drawRRect(outerRect, outerPaint);

    // 2. Inner Border
    final innerPaint = Paint()
      ..color = goldColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.85;

    final innerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 8, w - 16, h - 16),
      const Radius.circular(5),
    );
    canvas.drawRRect(innerRect, innerPaint);

    // 3. Header separator line (at y = 36)
    final headerSepPaint = Paint()
      ..color = goldColor.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawLine(const Offset(8, 36), Offset(w - 8, 36), headerSepPaint);

    // 4. Footer separator line (at y = h - 34)
    canvas.drawLine(Offset(8, h - 34), Offset(w - 8, h - 34), headerSepPaint);

    // 5. Four Corner Geometric Star Ornaments
    _drawCornerOrnament(canvas, 8, 8, goldColor);
    _drawCornerOrnament(canvas, w - 8, 8, goldColor);
    _drawCornerOrnament(canvas, 8, h - 8, goldColor);
    _drawCornerOrnament(canvas, w - 8, h - 8, goldColor);
  }

  void _drawCornerOrnament(Canvas canvas, double x, double y, Color color) {
    final dotPaint = Paint()
      ..color = color.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), 2.0, dotPaint);

    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    canvas.drawLine(Offset(x - 4, y), Offset(x + 4, y), linePaint);
    canvas.drawLine(Offset(x, y - 4), Offset(x, y + 4), linePaint);
  }

  @override
  bool shouldRepaint(covariant MushafFramePainter oldDelegate) {
    return oldDelegate.goldColor != goldColor ||
        oldDelegate.borderColor != borderColor;
  }
}

/// Represents a distinct section of ayahs on a page, optionally preceded by a Surah title and Bismillah
class _AyahBlock {
  final QuranSurahMeta? surahMeta;
  final bool showBismillah;
  final List<QuranAyah> ayahs;

  _AyahBlock({
    this.surahMeta,
    this.showBismillah = false,
    required this.ayahs,
  });
}

/// A single authentic Madani Mushaf Page widget (1 to 604)
/// Top header, justified flowing ayahs starting at top, and bottom page medallion.
class QuranMushafPageWidget extends StatefulWidget {
  final int pageNumber;
  final List<QuranAyah> ayahs;
  final QuranSurahMeta? Function(int surahNumber) getSurahMeta;
  final int? highlightedSurahNumber;
  final int? highlightedAyahNumber;
  final Set<String> bookmarkedAyahs;
  final Function(QuranAyah) onAyahTap;
  final VoidCallback? onOpenJumpSheet;
  final bool isRtl;
  final String language;

  const QuranMushafPageWidget({
    super.key,
    required this.pageNumber,
    required this.ayahs,
    required this.getSurahMeta,
    required this.highlightedSurahNumber,
    required this.highlightedAyahNumber,
    required this.bookmarkedAyahs,
    required this.onAyahTap,
    this.onOpenJumpSheet,
    required this.isRtl,
    required this.language,
  });

  @override
  State<QuranMushafPageWidget> createState() => _QuranMushafPageWidgetState();
}

class _QuranMushafPageWidgetState extends State<QuranMushafPageWidget> {
  final List<TapGestureRecognizer> _tapRecognizers = [];

  @override
  void dispose() {
    for (final r in _tapRecognizers) {
      r.dispose();
    }
    _tapRecognizers.clear();
    super.dispose();
  }

  /// Groups the page's ayahs into blocks, separating when a new Surah starts
  List<_AyahBlock> _groupIntoBlocks() {
    final blocks = <_AyahBlock>[];
    int currentSurah = -1;
    List<QuranAyah> currentAyahs = [];
    QuranSurahMeta? blockSurahMeta;
    bool blockShowBismillah = false;

    void flush() {
      if (currentAyahs.isNotEmpty) {
        blocks.add(_AyahBlock(
          surahMeta: blockSurahMeta,
          showBismillah: blockShowBismillah,
          ayahs: List.unmodifiable(currentAyahs),
        ));
        currentAyahs = [];
        blockSurahMeta = null;
        blockShowBismillah = false;
      }
    }

    for (int i = 0; i < widget.ayahs.length; i++) {
      final ayah = widget.ayahs[i];
      if (ayah.ayah == 1 || ayah.surah != currentSurah) {
        flush();
        currentSurah = ayah.surah;
        if (ayah.ayah == 1) {
          final meta = widget.getSurahMeta(ayah.surah);
          blockSurahMeta = meta;
          blockShowBismillah = meta != null && meta.number != 9 && meta.number != 1;
        }
      }
      currentAyahs.add(ayah);
    }
    flush();
    return blocks;
  }

  /// Line height stepped by font size to maintain authentic Madani spacing with diacritics
  double _getLineHeight(double fontSize) {
    if (widget.pageNumber <= 2) return 2.25;
    if (fontSize < 14.5) return 1.85;
    if (fontSize < 17.0) return 1.95;
    return 2.05;
  }

  /// Measures total rendered height of the blocks at a given fontSize
  double _measureContentHeight(
    List<_AyahBlock> blocks,
    double fontSize,
    double availableWidth,
  ) {
    final lineHeight = _getLineHeight(fontSize);
    double totalHeight = 0;

    for (final block in blocks) {
      if (block.surahMeta != null) {
        // Banner height: vertical margin 6 + padding 6 + border 2 + content ~24 = 38
        totalHeight += 38.0;
        if (block.showBismillah) {
          // Bismillah height: vertical padding 3 + text ~19 = 22
          totalHeight += 22.0;
        }
      }

      final spans = <InlineSpan>[];
      for (final ayah in block.ayahs) {
        spans.add(
          TextSpan(
            text: ayah.text,
            style: AppTheme.quranAyahText(
              fontSize: fontSize,
              height: lineHeight,
            ),
          ),
        );
        spans.add(
          TextSpan(
            text: ' ﴿${toArabicDigits(ayah.ayah)}﴾ ',
            style: AppTheme.quranAyahText(
              fontSize: fontSize * 0.72,
              height: lineHeight,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      final tp = TextPainter(
        text: TextSpan(children: spans),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
      );
      tp.layout(maxWidth: availableWidth);
      totalHeight += tp.size.height + 4.0;
      tp.dispose();
    }

    return totalHeight;
  }

  /// Binary search to find optimal font size ensuring all ayah lines fit without scrolling
  double _calculateOptimalFontSize({
    required List<_AyahBlock> blocks,
    required double availableWidth,
    required double availableHeight,
  }) {
    if (widget.pageNumber <= 2) {
      // Opening pages (Al-Fatiha, Al-Baqarah 1-5)
      double low = 18.0;
      double high = 24.0;
      double best = low;
      for (int i = 0; i < 6; i++) {
        final mid = (low + high) / 2.0;
        if (_measureContentHeight(blocks, mid, availableWidth) <= availableHeight) {
          best = mid;
          low = mid;
        } else {
          high = mid;
        }
      }
      return best;
    }

    // Standard pages (3 to 604)
    double low = 12.0;
    double high = 21.0;
    double best = low;

    for (int i = 0; i < 7; i++) {
      final mid = (low + high) / 2.0;
      final h = _measureContentHeight(blocks, mid, availableWidth);
      if (h <= availableHeight) {
        best = mid;
        low = mid;
      } else {
        high = mid;
      }
    }
    return best;
  }

  @override
  Widget build(BuildContext context) {
    for (final r in _tapRecognizers) {
      r.dispose();
    }
    _tapRecognizers.clear();

    if (widget.ayahs.isEmpty) {
      return Center(
        child: Text(
          'لاپەڕە ${toArabicDigits(widget.pageNumber)}',
          style: AppTheme.quranAyahText(fontSize: 18, color: AppColors.gold),
        ),
      );
    }

    final firstAyah = widget.ayahs.first;
    final primarySurah = widget.getSurahMeta(firstAyah.surah);
    final juzNumber = firstAyah.juz;
    final juzTitle = getArabicJuzTitle(juzNumber);
    final surahTitle = primarySurah != null
        ? 'سُورَةُ ${primarySurah.arabicName}'
        : 'سُورَةُ';

    return LayoutBuilder(
      builder: (context, constraints) {
        final blocks = _groupIntoBlocks();

        const double cardMarginH = 10.0;
        const double cardMarginV = 4.0;
        const double cardPadH = 12.0;
        const double cardPadTop = 6.0;
        const double cardPadBottom = 6.0;
        const double headerHeight = 24.0;
        const double headerSpacing = 4.0;
        const double footerHeight = 24.0;
        const double footerSpacing = 4.0;

        final double availableWidth = (constraints.maxWidth - (cardMarginH * 2) - (cardPadH * 2)).clamp(100.0, 1400.0);
        final double availableBodyHeight = (constraints.maxHeight -
                (cardMarginV * 2) -
                cardPadTop -
                cardPadBottom -
                headerHeight -
                headerSpacing -
                footerHeight -
                footerSpacing)
            .clamp(50.0, 3000.0);

        final optimalFontSize = _calculateOptimalFontSize(
          blocks: blocks,
          availableWidth: availableWidth,
          availableHeight: availableBodyHeight,
        );
        final optimalLineHeight = _getLineHeight(optimalFontSize);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: cardMarginH, vertical: cardMarginV),
          decoration: BoxDecoration(
            color: AppColors.darkPanel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.panelBorderColor.withValues(alpha: 0.5),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomPaint(
            painter: MushafFramePainter(
              goldColor: AppColors.gold,
              borderColor: AppColors.panelBorderColor,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(cardPadH, cardPadTop, cardPadH, cardPadBottom),
              child: Column(
                children: [
                  // ══════════════════════════════════════════════════════════════
                  // 1. TOP HEADER BAR — Surah Name & Juz Title (like before edit)
                  // ══════════════════════════════════════════════════════════════
                  SizedBox(
                    height: headerHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Juz badge
                        Expanded(
                          child: Text(
                            juzTitle,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.quranAyahText(
                              fontSize: 11.5,
                              color: AppColors.gold.withValues(alpha: 0.85),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Center Cartouche Badge: Hizb or Juz badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.gold.withValues(alpha: 0.3),
                              width: 0.6,
                            ),
                          ),
                          child: Text(
                            '۞ الجُزْءُ ${toArabicDigits(juzNumber)} ۞',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                        // Right: Surah name
                        Expanded(
                          child: Text(
                            surahTitle,
                            textAlign: TextAlign.end,
                            textDirection: TextDirection.rtl,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.quranAyahText(
                              fontSize: 12.5,
                              color: AppColors.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: headerSpacing),

                  // ══════════════════════════════════════════════════════════════
                  // 2. PAGE BODY — Ayahs starting cleanly at TOP with zero scroll
                  // ══════════════════════════════════════════════════════════════
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: availableWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final block in blocks) ...[
                                if (block.surahMeta != null) ...[
                                  _buildSurahTitleBanner(block.surahMeta!),
                                  if (block.showBismillah) _buildBismillahBanner(),
                                ],
                                _buildAyahsParagraph(block.ayahs, optimalFontSize, optimalLineHeight),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: footerSpacing),

                  // ══════════════════════════════════════════════════════════════
                  // 3. BOTTOM FOOTER BAR — Ornate Eastern Arabic Page Medallion
                  // ══════════════════════════════════════════════════════════════
                  SizedBox(
                    height: footerHeight,
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: widget.onOpenJumpSheet,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.gold.withValues(alpha: 0.35),
                              width: 0.7,
                            ),
                          ),
                          child: Text(
                            '﴿ ${toArabicDigits(widget.pageNumber)} ﴾',
                            style: AppTheme.quranAyahText(
                              fontSize: 13.5,
                              color: AppColors.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Authentic Islamic floral cartouche / banner for Surah Titles
  Widget _buildSurahTitleBanner(QuranSurahMeta surah) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withValues(alpha: 0.2),
            AppColors.darkBgAlt,
            AppColors.gold.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.55),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star_rounded, color: AppColors.gold, size: 13),
              const SizedBox(width: 6),
              Text(
                'سُورَةُ ${surah.arabicName}',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: AppTheme.quranAyahText(
                  fontSize: 16,
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.star_rounded, color: AppColors.gold, size: 13),
            ],
          ),
          const SizedBox(height: 1),
          Text(
            '${surah.revelationType == 'Meccan' ? 'مَكِّيَّةٌ' : 'مَدَنِيَّةٌ'}  •  ${toArabicDigits(surah.numberOfAyahs)} آيَاتٍ',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.gold.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  /// Calligraphic Bismillah Banner with ornamental flourishes
  Widget _buildBismillahBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Text(
          'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTheme.quranAyahText(
            fontSize: 15,
            color: AppColors.cream,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Flowing paragraph of justified Quranic Arabic text with tap recognizers & ayah end medallions
  Widget _buildAyahsParagraph(
    List<QuranAyah> ayahs,
    double fontSize,
    double lineHeight,
  ) {
    final spans = <InlineSpan>[];

    for (final ayah in ayahs) {
      final isHighlighted = widget.highlightedSurahNumber == ayah.surah &&
          widget.highlightedAyahNumber == ayah.ayah;
      final isBookmarked =
          widget.bookmarkedAyahs.contains('${ayah.surah}:${ayah.ayah}');

      final recognizer = TapGestureRecognizer()
        ..onTap = () => widget.onAyahTap(ayah);
      _tapRecognizers.add(recognizer);

      // 1. Ayah Text
      spans.add(
        TextSpan(
          text: ayah.text,
          recognizer: recognizer,
          style: isHighlighted
              ? AppTheme.quranAyahText(
                  fontSize: fontSize,
                  height: lineHeight,
                  color: AppColors.cream,
                ).copyWith(
                  backgroundColor: AppColors.gold.withValues(alpha: 0.28),
                )
              : null,
        ),
      );

      // 2. Bookmark indicator if bookmarked
      if (isBookmarked) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.bookmark_rounded,
                size: fontSize * 0.65,
                color: AppColors.gold,
              ),
            ),
          ),
        );
      }

      // 3. Ornate Ayah End Medallion with Eastern Arabic digits
      spans.add(
        TextSpan(
          text: ' ﴿${toArabicDigits(ayah.ayah)}﴾ ',
          recognizer: recognizer,
          style: AppTheme.quranAyahText(
            fontSize: fontSize * 0.72,
            height: lineHeight,
            color: isHighlighted ? AppColors.gold : AppColors.gold.withValues(alpha: 0.95),
            fontWeight: FontWeight.bold,
          ).copyWith(
            backgroundColor: isHighlighted
                ? AppColors.gold.withValues(alpha: 0.28)
                : null,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text.rich(
        TextSpan(children: spans),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
        style: AppTheme.quranAyahText(
          fontSize: fontSize,
          height: lineHeight,
        ),
      ),
    );
  }
}

/// Floating bottom navigation bar for Real Mushaf Page Mode
/// Sleek, low-profile design that maximizes height for the ayah lines above it.
class MushafBottomNavigationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  final VoidCallback onOpenJumpSheet;
  final String language;

  const MushafBottomNavigationBar({
    super.key,
    required this.currentPage,
    this.totalPages = 604,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.onOpenJumpSheet,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final pageLabel = language == 'kmr'
        ? 'بەرپەر ${toArabicDigits(currentPage)} ژ ${toArabicDigits(totalPages)}'
        : language == 'ku'
            ? 'لاپەڕە ${toArabicDigits(currentPage)} لە ${toArabicDigits(totalPages)}'
            : language == 'ar'
                ? 'صفحة ${toArabicDigits(currentPage)} من ${toArabicDigits(totalPages)}'
                : 'Page $currentPage of $totalPages';

    final nextLabel = language == 'kmr'
        ? 'پاشتر'
        : language == 'ku'
            ? 'دواتر'
            : language == 'ar'
                ? 'التالي'
                : 'Next';

    final prevLabel = language == 'kmr'
        ? 'پێشتر'
        : language == 'ku'
            ? 'پێشتر'
            : language == 'ar'
                ? 'السابق'
                : 'Prev';

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 2, 16, 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.darkBgAlt.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.35),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Next Page (in RTL, forward is left arrow / next)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: currentPage < totalPages ? onNextPage : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 13,
                      color: currentPage < totalPages
                          ? AppColors.gold
                          : AppColors.mutedText.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      nextLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: currentPage < totalPages
                            ? AppColors.gold
                            : AppColors.mutedText.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Center: Clickable Page Badge to open Jump Sheet
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onOpenJumpSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.3),
                    width: 0.7,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_stories_rounded, color: AppColors.gold, size: 13),
                    const SizedBox(width: 6),
                    Text(
                      pageLabel,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.unfold_more_rounded, color: AppColors.gold, size: 13),
                  ],
                ),
              ),
            ),
          ),

          // Previous Page (in RTL, backward is right arrow / prev)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: currentPage > 1 ? onPreviousPage : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      prevLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: currentPage > 1
                            ? AppColors.gold
                            : AppColors.mutedText.withValues(alpha: 0.4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13,
                      color: currentPage > 1
                          ? AppColors.gold
                          : AppColors.mutedText.withValues(alpha: 0.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
