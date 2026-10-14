import WidgetKit
import SwiftUI

private let appGroupId = "group.com.nada.nadaZikrakanm"

// MARK: - Color Hex Initializer

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255.0,
            green: Double((hex >> 08) & 0xff) / 255.0,
            blue: Double((hex >> 00) & 0xff) / 255.0,
            opacity: alpha
        )
    }
}

// MARK: - Theme Color Palettes (Synchronized with Flutter AppPalettes)

struct ThemeColors {
    let background: LinearGradient
    let cardBackground: Color
    let cardBorder: Color
    let primary: Color      // Gold / Accent color
    let secondary: Color    // Light / Cream text color
    let muted: Color        // Faint / Muted subtext
    let cellActiveBg: Color
    let isLight: Bool

    static func forTheme(_ key: String?) -> ThemeColors {
        switch key {
        case "obsidian":
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0x0A0D10), Color(hex: 0x12171C), Color(hex: 0x1B222A)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0xFFD700).opacity(0.12),
                cardBorder: Color(hex: 0xFFD700).opacity(0.35),
                primary: Color(hex: 0xFFFFD700),
                secondary: Color(hex: 0xFAF9F6),
                muted: Color(hex: 0x9CA5B0),
                cellActiveBg: Color(hex: 0xFFFFD700).opacity(0.18),
                isLight: false
            )
        case "sunrise": // Golden Dawn (Daylight Amber & Cream)
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0xF5EFE4), Color(hex: 0xECE2CF), Color(hex: 0xDFD2BA)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0x9A5B0B).opacity(0.12),
                cardBorder: Color(hex: 0x9A5B0B).opacity(0.30),
                primary: Color(hex: 0x9A5B0B),
                secondary: Color(hex: 0x1C140A), // Deep high-contrast text for daylight
                muted: Color(hex: 0x64513C),
                cellActiveBg: Color(hex: 0x9A5B0B).opacity(0.16),
                isLight: true
            )
        case "forest":
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0x081812), Color(hex: 0x102A20), Color(hex: 0x16382C)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0x52B788).opacity(0.14),
                cardBorder: Color(hex: 0x52B788).opacity(0.35),
                primary: Color(hex: 0xD4AF37),
                secondary: Color(hex: 0xF2F7EF),
                muted: Color(hex: 0x8FA89B),
                cellActiveBg: Color(hex: 0xD4AF37).opacity(0.18),
                isLight: false
            )
        case "dusk":
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0x120C1D), Color(hex: 0x1B122C), Color(hex: 0x261A3E)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0xC084FC).opacity(0.14),
                cardBorder: Color(hex: 0xC084FC).opacity(0.35),
                primary: Color(hex: 0xF6C86D),
                secondary: Color(hex: 0xF8F3FE),
                muted: Color(hex: 0xA592C0),
                cellActiveBg: Color(hex: 0xF6C86D).opacity(0.18),
                isLight: false
            )
        case "ocean":
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0x07111D), Color(hex: 0x0E1F34), Color(hex: 0x142B47)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0x38BDF8).opacity(0.14),
                cardBorder: Color(hex: 0x38BDF8).opacity(0.35),
                primary: Color(hex: 0x38BDF8),
                secondary: Color(hex: 0xF0F7FF),
                muted: Color(hex: 0x7FAACF),
                cellActiveBg: Color(hex: 0x38BDF8).opacity(0.18),
                isLight: false
            )
        case "rose":
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0x180A12), Color(hex: 0x28101E), Color(hex: 0x36162A)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0xFB7185).opacity(0.14),
                cardBorder: Color(hex: 0xFB7185).opacity(0.35),
                primary: Color(hex: 0xF6A97A),
                secondary: Color(hex: 0xFFF0F5),
                muted: Color(hex: 0xBA8F9F),
                cellActiveBg: Color(hex: 0xF6A97A).opacity(0.18),
                isLight: false
            )
        case "oled":
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0x000000), Color(hex: 0x070707), Color(hex: 0x0F0F0F)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0xFFD700).opacity(0.10),
                cardBorder: Color(hex: 0xFFD700).opacity(0.35),
                primary: Color(hex: 0xFFFFD700),
                secondary: Color(hex: 0xFFFFFF),
                muted: Color(hex: 0xA0A0A0),
                cellActiveBg: Color(hex: 0xFFFFD700).opacity(0.18),
                isLight: false
            )
        default: // "nuri" / Kurdish Emerald Classic
            return ThemeColors(
                background: LinearGradient(
                    colors: [Color(hex: 0x07140E), Color(hex: 0x0D2A1C), Color(hex: 0x143826)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                cardBackground: Color(hex: 0x4DAE8C).opacity(0.14),
                cardBorder: Color(hex: 0x4DAE8C).opacity(0.35),
                primary: Color(hex: 0xD4AF37),
                secondary: Color(hex: 0xF7F2E7),
                muted: Color(hex: 0x98B8A4),
                cellActiveBg: Color(hex: 0xD4AF37).opacity(0.18),
                isLight: false
            )
        }
    }
}

// MARK: - Prayer Data Model

struct PrayerEntry: TimelineEntry {
    let date: Date
    let cityName: String
    let hijriDate: String

    // Next upcoming prayer
    let nextPrayerName: String
    let nextPrayerTime: String
    let nextPrayerTimestamp: Double
    let nextPrayerId: String

    // All 6 prayer times
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String

    let isKurdish: Bool
    let isArabic: Bool
    let themeKey: String

    // MARK: - Live Countdown (always accurate — computed fresh at every SwiftUI render)
    var nextPrayerDate: Date? {
        guard nextPrayerTimestamp > 0 else { return nil }
        return Date(timeIntervalSince1970: nextPrayerTimestamp)
    }

    var liveRemainingText: String {
        guard nextPrayerTimestamp > 0 else { return "" }
        let target = Date(timeIntervalSince1970: nextPrayerTimestamp)
        let diff = target.timeIntervalSince(Date())
        if diff <= 0 {
            return isKurdish ? "کاتی بانگە" : (isArabic ? "حان وقت الأذان" : "Prayer Time")
        }
        let hours = Int(diff) / 3600
        let minutes = (Int(diff) % 3600) / 60
        if hours > 0 {
            return isKurdish
                ? "\(hours) کاتژمێر و \(minutes) خولەک ماوە"
                : (isArabic ? "باقي \(hours) ساعة و \(minutes) دقيقة" : "in \(hours)h \(minutes)m")
        } else {
            return isKurdish
                ? "\(minutes) خولەک ماوە"
                : (isArabic ? "باقي \(minutes) دقيقة" : "in \(minutes) mins")
        }
    }
}

// MARK: - Helpers

private struct PrayerSlot: Identifiable {
    let id: String
    let nameKu: String
    let nameAr: String
    let nameEn: String
    let iconName: String
    let time: String
    var isNext: Bool = false
}

// MARK: - Timeline Provider

struct PrayerTimelineProvider: TimelineProvider {

    private func readString(_ prefs: UserDefaults?, keys: [String], fallback: String) -> String {
        for key in keys {
            if let value = prefs?.string(forKey: key)?.trimmingCharacters(in: .whitespacesAndNewlines),
               !value.isEmpty, value != "--:--" {
                return value
            }
        }
        return fallback
    }

    func placeholder(in context: Context) -> PrayerEntry {
        PrayerEntry(
            date: Date(),
            cityName: "هەولێر",
            hijriDate: "١٤ سەفەر ١٤٤٨",
            nextPrayerName: "بانگی عەسر",
            nextPrayerTime: "03:45 PM",
            nextPrayerTimestamp: Date().addingTimeInterval(25 * 60).timeIntervalSince1970,
            nextPrayerId: "asr",
            fajr: "04:12",
            sunrise: "05:38",
            dhuhr: "12:15",
            asr: "03:45",
            maghrib: "06:50",
            isha: "08:15",
            isKurdish: true,
            isArabic: false,
            themeKey: "nuri"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (PrayerEntry) -> ()) {
        completion(fetchCurrentEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayerEntry>) -> ()) {
        let entry = fetchCurrentEntry()
        let now = Date()
        let cal = Calendar.current

        // Parse all prayer time strings into future Date objects for today
        let timeStrings: [String] = [entry.fajr, entry.sunrise, entry.dhuhr, entry.asr, entry.maghrib, entry.isha]
        var futureDates: [Date] = timeStrings.compactMap { timeStr -> Date? in
            guard timeStr != "--:--" else { return nil }
            let parts = timeStr.components(separatedBy: CharacterSet(charactersIn: " :"))
            guard parts.count >= 2, let h = Int(parts[0]), let m = Int(parts[1]) else { return nil }
            var hour = h
            if parts.count >= 3 {
                let ampm = parts[2].uppercased()
                if ampm == "PM" && h != 12 { hour = h + 12 }
                if ampm == "AM" && h == 12 { hour = 0 }
            }
            var comps = cal.dateComponents([.year, .month, .day], from: now)
            comps.hour = hour; comps.minute = m; comps.second = 0
            return cal.date(from: comps)
        }.filter { $0 > now }.sorted()

        // Also refresh every 15 minutes as fallback
        futureDates.append(now.addingTimeInterval(900))

        // Build an entry for each refresh point (widget re-reads SharedPrefs at each date)
        let extraEntries: [PrayerEntry] = futureDates.prefix(7).map { date in
            PrayerEntry(
                date: date,
                cityName: entry.cityName, hijriDate: entry.hijriDate,
                nextPrayerName: entry.nextPrayerName, nextPrayerTime: entry.nextPrayerTime,
                nextPrayerTimestamp: entry.nextPrayerTimestamp, nextPrayerId: entry.nextPrayerId,
                fajr: entry.fajr, sunrise: entry.sunrise, dhuhr: entry.dhuhr,
                asr: entry.asr, maghrib: entry.maghrib, isha: entry.isha,
                isKurdish: entry.isKurdish, isArabic: entry.isArabic, themeKey: entry.themeKey
            )
        }
        let policyDate = futureDates.last ?? now.addingTimeInterval(900)
        let timeline = Timeline(entries: [entry] + extraEntries, policy: .after(policyDate))
        completion(timeline)
    }


    private func fetchCurrentEntry() -> PrayerEntry {
        let prefs = UserDefaults(suiteName: appGroupId)
        let lang = prefs?.string(forKey: "lang") ?? "ku"
        let isKurdish = lang == "ku"
        let isArabic  = lang == "ar"

        let defaultCity       = isKurdish ? "کوردستان" : (isArabic ? "كردستان" : "Kurdistan")
        let defaultNextPrayer = isKurdish ? "بانگی داهاتوو" : (isArabic ? "الصلاة القادمة" : "Next Prayer")

        let cityName       = readString(prefs, keys: ["city_name"], fallback: defaultCity)
        let hijriDate      = readString(prefs, keys: ["hijri_date"], fallback: "")
        let nextPrayerName = readString(prefs, keys: ["next_prayer_name", "selected_prayer_name"], fallback: defaultNextPrayer)
        let nextPrayerTime = readString(prefs, keys: ["next_prayer_time", "selected_prayer_time"], fallback: "--:--")
        let nextPrayerId   = prefs?.string(forKey: "next_prayer_id") ?? "fajr"
        let nextPrayerTimestamp = prefs?.double(forKey: "next_prayer_timestamp") ?? 0

        let fajr    = readString(prefs, keys: ["fajr_time"],    fallback: "--:--")
        let sunrise = readString(prefs, keys: ["sunrise_time"], fallback: "--:--")
        let dhuhr   = readString(prefs, keys: ["dhuhr_time"],   fallback: "--:--")
        let asr     = readString(prefs, keys: ["asr_time"],     fallback: "--:--")
        let maghrib = readString(prefs, keys: ["maghrib_time"], fallback: "--:--")
        let isha    = readString(prefs, keys: ["isha_time"],     fallback: "--:--")

        let themeKey = prefs?.string(forKey: "theme_key") ?? "nuri"

        return PrayerEntry(
            date: Date(),
            cityName: cityName,
            hijriDate: hijriDate,
            nextPrayerName: nextPrayerName,
            nextPrayerTime: nextPrayerTime,
            nextPrayerTimestamp: nextPrayerTimestamp,
            nextPrayerId: nextPrayerId,
            fajr: fajr,
            sunrise: sunrise,
            dhuhr: dhuhr,
            asr: asr,
            maghrib: maghrib,
            isha: isha,
            isKurdish: isKurdish,
            isArabic: isArabic,
            themeKey: themeKey
        )
    }
}

// MARK: - Shared Views

private struct PrayerCard: View {
    let name: String
    let time: String
    let iconName: String
    let isNext: Bool
    let textColor: Color
    let activeColor: Color
    let activeBg: Color
    let inactiveBg: Color
    let activeBorder: Color

    private var cleanTime: String {
        let parts = time.components(separatedBy: " ")
        return parts.first ?? time
    }

    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: iconName)
                .font(.system(size: 13, weight: isNext ? .bold : .medium))
                .foregroundColor(isNext ? activeColor : textColor.opacity(0.85))
                .frame(height: 14)

            Text(name)
                .font(.system(size: 9.5, weight: isNext ? .bold : .medium))
                .foregroundColor(isNext ? activeColor : textColor.opacity(0.85))
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(cleanTime)
                .font(.system(size: 11, weight: isNext ? .bold : .semibold, design: .monospaced))
                .foregroundColor(isNext ? activeColor : textColor)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 4)
        .padding(.horizontal, 2)
        .background(isNext ? activeBg : inactiveBg)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(isNext ? activeBorder : Color.clear, lineWidth: isNext ? 1.5 : 0)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

// MARK: - Widget Entry View

struct PrayerTimesWidgetEntryView: View {
    var entry: PrayerTimelineProvider.Entry
    @Environment(\.widgetFamily) var family

    private var theme: ThemeColors {
        ThemeColors.forTheme(entry.themeKey)
    }

    private func prayerSlots() -> [PrayerSlot] {
        [
            PrayerSlot(id: "fajr",    nameKu: "بەیانی",     nameAr: "الفجر",   nameEn: "Fajr",    iconName: "sun.horizon.fill",     time: entry.fajr,    isNext: entry.nextPrayerId == "fajr"),
            PrayerSlot(id: "sunrise", nameKu: "خۆرهەڵاتن",  nameAr: "الشروق",  nameEn: "Sunrise", iconName: "sun.and.horizon.fill", time: entry.sunrise, isNext: entry.nextPrayerId == "sunrise"),
            PrayerSlot(id: "dhuhr",   nameKu: "نیوەڕۆ",     nameAr: "الظهر",   nameEn: "Dhuhr",   iconName: "sun.max.fill",         time: entry.dhuhr,   isNext: entry.nextPrayerId == "dhuhr"),
            PrayerSlot(id: "asr",     nameKu: "عەسر",       nameAr: "العصر",   nameEn: "Asr",     iconName: "sun.haze.fill",        time: entry.asr,     isNext: entry.nextPrayerId == "asr"),
            PrayerSlot(id: "maghrib", nameKu: "شێوان",      nameAr: "المغرب",  nameEn: "Maghrib", iconName: "sunset.fill",          time: entry.maghrib, isNext: entry.nextPrayerId == "maghrib"),
            PrayerSlot(id: "isha",    nameKu: "خەوتنان",    nameAr: "العشاء",  nameEn: "Isha",    iconName: "moon.stars.fill",      time: entry.isha,    isNext: entry.nextPrayerId == "isha"),
        ]
    }

    private func upcomingThreeSlots() -> [PrayerSlot] {
        let slots = prayerSlots()
        if let nextIndex = slots.firstIndex(where: { $0.isNext }) {
            var result: [PrayerSlot] = []
            for i in 0..<3 {
                result.append(slots[(nextIndex + i) % slots.count])
            }
            return result
        }
        return Array(slots.prefix(3))
    }

    private func prayerName(_ slot: PrayerSlot) -> String {
        if entry.isKurdish { return slot.nameKu }
        if entry.isArabic  { return slot.nameAr }
        return slot.nameEn
    }

    private var appTitle: String {
        (entry.isKurdish || entry.isArabic) ? "نەدا" : "Nada"
    }

    private var remainingLabel: String {
        if entry.isKurdish { return "کاتی ماوە" }
        if entry.isArabic  { return "الوقت المتبقي" }
        return "Time Left"
    }

    private var cleanNextPrayerName: String {
        var name = entry.nextPrayerName
        if name.starts(with: "بانگی ") {
            name = String(name.dropFirst(6))
        } else if name.starts(with: "صلاة ") {
            name = String(name.dropFirst(5))
        }
        return name
    }

    private func cleanTime(_ timeStr: String) -> String {
        let parts = timeStr.components(separatedBy: " ")
        return parts.first ?? timeStr
    }

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget.widgetBackground(theme.background)
        case .systemMedium:
            mediumWidget.widgetBackground(theme.background)
        case .systemLarge:
            largeWidget.widgetBackground(theme.background)
        default:
            if #available(iOSApplicationExtension 16.0, *) {
                switch family {
                case .accessoryRectangular:
                    lockScreenRectangular.widgetBackground(Color.clear)
                case .accessoryInline:
                    lockScreenInline.widgetBackground(Color.clear)
                case .accessoryCircular:
                    lockScreenCircular.widgetBackground(Color.clear)
                default:
                    smallWidget.widgetBackground(theme.background)
                }
            } else {
                smallWidget.widgetBackground(theme.background)
            }
        }
    }

    // MARK: - Small Widget (Balanced, Compact, No Dead Space)
    var smallWidget: some View {
        VStack(spacing: 4) {
            // Top Header: City & Pin + App Title
            HStack(alignment: .center) {
                HStack(spacing: 3) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 11))
                        .foregroundColor(theme.primary)
                    Text(entry.cityName)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(theme.secondary)
                        .lineLimit(1)
                }
                Spacer()
                Text(appTitle)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(theme.primary)
            }

            // Hero Card: Next Prayer
            VStack(spacing: 2) {
                HStack(spacing: 4) {
                    if let nextSlot = prayerSlots().first(where: { $0.isNext }) {
                        Image(systemName: nextSlot.iconName)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(theme.primary)
                    }
                    Text(cleanNextPrayerName)
                        .font(.system(size: 11.5, weight: .bold))
                        .foregroundColor(theme.primary)
                        .lineLimit(1)
                }

                Text(cleanTime(entry.nextPrayerTime))
                    .font(.system(size: 21, weight: .heavy, design: .rounded))
                    .foregroundColor(theme.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                // Countdown Pill
                HStack(spacing: 3) {
                    if let target = entry.nextPrayerDate, target > Date() {
                        Text(target, style: .timer)
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(theme.primary)
                            .lineLimit(1)
                    } else {
                        Text(entry.liveRemainingText.isEmpty ? (entry.isKurdish ? "کاتی بانگە" : "Now") : entry.liveRemainingText)
                            .font(.system(size: 9.5, weight: .bold))
                            .foregroundColor(theme.primary)
                            .lineLimit(1)
                    }
                    Text("⌛")
                        .font(.system(size: 9))
                }
                .padding(.horizontal, 7)
                .padding(.vertical, 2.5)
                .background(theme.cardBackground)
                .overlay(Capsule().stroke(theme.cardBorder, lineWidth: 0.8))
                .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 3)
            .background(theme.cellActiveBg.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(theme.cardBorder, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            // Mini 3-Prayer bar at bottom (Fills remaining space without blank gap)
            HStack(spacing: 3) {
                let slots = upcomingThreeSlots()
                ForEach(slots) { slot in
                    VStack(spacing: 1) {
                        Text(prayerName(slot))
                            .font(.system(size: 8, weight: slot.isNext ? .bold : .medium))
                            .foregroundColor(slot.isNext ? theme.primary : theme.secondary.opacity(0.8))
                            .lineLimit(1)
                        Text(cleanTime(slot.time))
                            .font(.system(size: 8.5, weight: slot.isNext ? .bold : .regular, design: .monospaced))
                            .foregroundColor(slot.isNext ? theme.primary : theme.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2.5)
                    .background(slot.isNext ? theme.cellActiveBg : theme.cardBackground.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                }
            }
        }
        .padding(9)
        .environment(\.layoutDirection, (entry.isKurdish || entry.isArabic) ? .rightToLeft : .leftToRight)
    }

    // MARK: - Medium Widget (Header, Next Prayer Hero & 6-Prayer Schedule – Identical to Screenshot)
    var mediumWidget: some View {
        VStack(spacing: 6) {
            // Header (Top Line)
            HStack(alignment: .center) {
                // Right (in RTL): City + Pin
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 13))
                        .foregroundColor(theme.primary)
                    Text(entry.cityName)
                        .font(.system(size: 12.5, weight: .bold))
                        .foregroundColor(theme.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 4)

                // Left (in RTL): "کاتی ماوە"
                Text(remainingLabel)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(theme.muted)
                    .lineLimit(1)
            }

            // Subheader (Hero Line)
            HStack(alignment: .center, spacing: 6) {
                // Right (in RTL): Next prayer title + name + time badge
                HStack(spacing: 4) {
                    Text(entry.isKurdish ? "بانگی داهاتوو:" : (entry.isArabic ? "الصلاة القادمة:" : "Next:"))
                        .font(.system(size: 10.5, weight: .medium))
                        .foregroundColor(theme.secondary.opacity(0.85))
                        .lineLimit(1)

                    Text(cleanNextPrayerName)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(theme.primary)
                        .lineLimit(1)

                    HStack(spacing: 3) {
                        Text(cleanTime(entry.nextPrayerTime))
                            .font(.system(size: 10.5, weight: .bold, design: .monospaced))
                            .foregroundColor(theme.primary)
                            .lineLimit(1)
                        Image(systemName: "clock.fill")
                            .font(.system(size: 8.5))
                            .foregroundColor(theme.primary)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(theme.cardBackground)
                    .overlay(Capsule().stroke(theme.cardBorder, lineWidth: 0.8))
                    .clipShape(Capsule())
                }

                Spacer(minLength: 4)

                // Left (in RTL): Countdown Pill
                HStack(spacing: 3) {
                    if let target = entry.nextPrayerDate, target > Date() {
                        Text(target, style: .timer)
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(theme.primary)
                            .lineLimit(1)
                    } else {
                        Text(entry.liveRemainingText.isEmpty ? (entry.isKurdish ? "کاتی بانگە" : "Now") : entry.liveRemainingText)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(theme.primary)
                            .lineLimit(1)
                    }
                    Text("⌛")
                        .font(.system(size: 9))
                }
                .padding(.horizontal, 7)
                .padding(.vertical, 2.5)
                .background(Color(hex: 0x071D18).opacity(0.85))
                .overlay(Capsule().stroke(theme.cardBorder, lineWidth: 0.9))
                .clipShape(Capsule())
            }

            // Bottom Line: 6 Prayer Cards filling all remaining space
            HStack(spacing: 4) {
                let slots = prayerSlots()
                ForEach(slots) { slot in
                    PrayerCard(
                        name: prayerName(slot),
                        time: slot.time,
                        iconName: slot.iconName,
                        isNext: slot.isNext,
                        textColor: theme.secondary,
                        activeColor: theme.primary,
                        activeBg: theme.cellActiveBg,
                        inactiveBg: theme.cardBackground.opacity(0.35),
                        activeBorder: theme.primary
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(10)
        .environment(\.layoutDirection, (entry.isKurdish || entry.isArabic) ? .rightToLeft : .leftToRight)
    }

    // MARK: - Large Widget (Spacious, Fully Balanced, Zero Empty Gaps)
    var largeWidget: some View {
        VStack(spacing: 8) {
            // Top Header: City & Pin + Hijri Date + App Title
            HStack(alignment: .center) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(theme.primary)
                    Text(entry.cityName)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(theme.secondary)
                }
                Spacer()
                if !entry.hijriDate.isEmpty {
                    Text(entry.hijriDate)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(theme.muted)
                }
            }

            // Hero Next Prayer Banner
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 4) {
                        Text(entry.isKurdish ? "بانگی داهاتوو:" : "Next Prayer:")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(theme.secondary.opacity(0.85))
                        Text(cleanNextPrayerName)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(theme.primary)
                    }

                    // Countdown Pill
                    HStack(spacing: 4) {
                        if let target = entry.nextPrayerDate, target > Date() {
                            Text(target, style: .timer)
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundColor(theme.primary)
                        } else {
                            Text(entry.liveRemainingText.isEmpty ? "Now" : entry.liveRemainingText)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(theme.primary)
                        }
                        Text("⌛")
                            .font(.system(size: 10))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3.5)
                    .background(theme.cellActiveBg)
                    .overlay(Capsule().stroke(theme.cardBorder, lineWidth: 1))
                    .clipShape(Capsule())
                }

                Spacer()

                Text(cleanTime(entry.nextPrayerTime))
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundColor(theme.primary)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
            }
            .padding(11)
            .background(theme.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(theme.cardBorder, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            // 6 Prayers filling remaining height evenly
            let slots = prayerSlots()
            VStack(spacing: 5) {
                ForEach(slots) { slot in
                    HStack(spacing: 10) {
                        Image(systemName: slot.iconName)
                            .font(.system(size: 13, weight: slot.isNext ? .bold : .medium))
                            .foregroundColor(slot.isNext ? theme.primary : theme.secondary.opacity(0.85))
                            .frame(width: 18)

                        Text(prayerName(slot))
                            .font(.system(size: 12.5, weight: slot.isNext ? .bold : .medium))
                            .foregroundColor(slot.isNext ? theme.primary : theme.secondary)
                            .lineLimit(1)

                        Spacer()

                        Text(cleanTime(slot.time))
                            .font(.system(size: 12.5, weight: slot.isNext ? .bold : .semibold, design: .monospaced))
                            .foregroundColor(slot.isNext ? theme.primary : theme.secondary)
                            .lineLimit(1)

                        if slot.isNext {
                            Circle()
                                .fill(theme.primary)
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.horizontal, 11)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(slot.isNext ? theme.cellActiveBg : theme.cardBackground.opacity(0.35))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(slot.isNext ? theme.cardBorder : Color.clear, lineWidth: slot.isNext ? 1 : 0)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(13)
        .environment(\.layoutDirection, (entry.isKurdish || entry.isArabic) ? .rightToLeft : .leftToRight)
    }

    // MARK: - Lock Screen Widgets (iOS 16+, No Emojis)

    @available(iOSApplicationExtension 16.0, *)
    var lockScreenRectangular: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(entry.cityName)
                    .font(.system(size: 10, weight: .semibold))
                    .lineLimit(1)
                Spacer()
                Text(entry.nextPrayerName)
                    .font(.system(size: 10, weight: .bold))
                    .lineLimit(1)
            }
            HStack(alignment: .firstTextBaseline) {
                Text(entry.nextPrayerTime)
                    .font(.system(size: 17, weight: .heavy, design: .rounded))
                    .lineLimit(1)
                Spacer()
                if !entry.liveRemainingText.isEmpty {
                    Text(entry.liveRemainingText)
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
    }

    @available(iOSApplicationExtension 16.0, *)
    var lockScreenInline: some View {
        Text("\(entry.nextPrayerName): \(entry.nextPrayerTime)")
    }

    @available(iOSApplicationExtension 16.0, *)
    var lockScreenCircular: some View {
        VStack(spacing: 1) {
            Text(entry.nextPrayerName)
                .font(.system(size: 10, weight: .semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text(entry.nextPrayerTime.components(separatedBy: " ").first ?? entry.nextPrayerTime)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
}

// MARK: - iOS 17+ Container Background & Margin Support

extension View {
    @ViewBuilder
    func widgetBackground<V: View>(_ backgroundView: V) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            background(backgroundView)
        }
    }
}

extension WidgetConfiguration {
    func contentMarginsDisabledIfAvailable() -> some WidgetConfiguration {
        if #available(iOSApplicationExtension 17.0, *) {
            return self.contentMarginsDisabled()
        } else {
            return self
        }
    }
}

// MARK: - Widget Entry Point

@main
struct PrayerTimesWidget: Widget {
    let kind: String = "PrayerTimesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PrayerTimelineProvider()) { entry in
            PrayerTimesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("نەدا • کاتەکانی بانگ")
        .description("شەونمی ئارامی بۆ دڵەکان — پیشاندانی کاتەکانی بانگ و یادی خوا")
        .supportedFamilies(supportedFamiliesList)
        .contentMarginsDisabledIfAvailable()
    }

    private var supportedFamiliesList: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [
                .systemSmall, .systemMedium, .systemLarge,
                .accessoryRectangular, .accessoryInline, .accessoryCircular
            ]
        } else {
            return [.systemSmall, .systemMedium, .systemLarge]
        }
    }
}
