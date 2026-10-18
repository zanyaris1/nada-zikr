import WidgetKit
import SwiftUI
import CoreLocation
#if canImport(AppIntents)
import AppIntents
#endif

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

// MARK: - Native Offline Prayer Calculator & Hijri Helper
// Used as high-precision offline fallback whenever App Group data is unavailable (e.g. Sideloading, SideStore, AltStore, fresh install)

struct NativePrayerTimes {
    let fajr: Date
    let sunrise: Date
    let dhuhr: Date
    let asr: Date
    let maghrib: Date
    let isha: Date
}

enum IslamicDateHelper {
    private static let kurdishMonths = [
        "موحەڕەم", "سەفەر", "ڕەبیعی یەکەم", "ڕەبیعی دووەم",
        "جومادای یەکەم", "جومادای دووەم", "ڕەجەب", "شەعبان",
        "ڕەمەزان", "شەووال", "زولقەعدە", "زولحەججە"
    ]
    private static let arabicMonths = [
        "محرم", "صفر", "ربيع الأول", "ربيع الثاني",
        "جمادى الأولى", "جمادى الآخرة", "رجب", "شعبان",
        "رمضان", "شوال", "ذو القعدة", "ذو الحجة"
    ]

    static func format(date: Date, isKurdish: Bool, isArabic: Bool) -> String {
        let cal = Calendar(identifier: .islamicUmmAlQura)
        let day = cal.component(.day, from: date)
        let month = cal.component(.month, from: date)
        let year = cal.component(.year, from: date)

        let monthName: String
        if month >= 1 && month <= 12 {
            monthName = isKurdish ? kurdishMonths[month - 1] : (isArabic ? arabicMonths[month - 1] : arabicMonths[month - 1])
        } else {
            monthName = ""
        }
        return "\(day) \(monthName) \(year)"
    }
}

enum NativePrayerCalculator {
    /// Authentic Kurdistan Regional Government Ministry of Endowments (Awqaf) Calibrated Standard
    static func calculate(
        date: Date,
        latitude: Double = 36.1911,   // Erbil / Kurdistan Regional Capital Standard
        longitude: Double = 44.0092,
        utcOffsetHours: Double = 3.0
    ) -> NativePrayerTimes {
        let cal = Calendar(identifier: .gregorian)
        let dayOfYear = cal.ordinality(of: .day, in: .year, for: date) ?? 1

        let gamma = (2.0 * Double.pi / 365.0) * Double(dayOfYear - 1)

        let eqOfTime = 229.18 * (
            0.000075 +
            0.001868 * cos(gamma) -
            0.032077 * sin(gamma) -
            0.014615 * cos(2.0 * gamma) -
            0.040849 * sin(2.0 * gamma)
        )

        let declination = 0.006918 -
            0.399912 * cos(gamma) +
            0.070257 * sin(gamma) -
            0.006758 * cos(2.0 * gamma) +
            0.000907 * sin(2.0 * gamma) -
            0.002697 * cos(3.0 * gamma) +
            0.00148 * sin(3.0 * gamma)

        // Solar noon in minutes from local midnight UTC+3
        let solarNoonMinutes = 720.0 - (4.0 * longitude) - eqOfTime + (utcOffsetHours * 60.0)

        func hourAngle(zenithDegrees: Double) -> Double {
            let latRad = latitude * Double.pi / 180.0
            let zenRad = zenithDegrees * Double.pi / 180.0
            let cosH = (cos(zenRad) - (sin(latRad) * sin(declination))) / (cos(latRad) * cos(declination))
            if cosH > 1.0 || cosH < -1.0 { return Double.nan }
            return acos(cosH) * 180.0 / Double.pi
        }

        func asrHourAngle(shadowFactor: Double = 1.0) -> Double {
            let latRad = latitude * Double.pi / 180.0
            let delta = abs(latRad - declination)
            let cotAlt = shadowFactor + tan(delta)
            let altRad = atan(1.0 / cotAlt)
            let cosH = (sin(altRad) - (sin(latRad) * sin(declination))) / (cos(latRad) * cos(declination))
            let clamped = max(-1.0, min(1.0, cosH))
            return acos(clamped) * 180.0 / Double.pi
        }

        let sunriseZenith = 90.833
        let sunriseHA = hourAngle(zenithDegrees: sunriseZenith)
        let astroSunriseMinutes = solarNoonMinutes - (sunriseHA * 4.0)
        let astroSunsetMinutes  = solarNoonMinutes + (sunriseHA * 4.0)

        // Kurdistan Ministry of Endowments (Awqaf) Standard:
        // - Dhuhr: Solar noon + 6 min zawal margin
        // - Sunrise: Astro sunrise + 6 min terrain margin
        // - Fajr: 19.5° Awqaf depression angle with Kurdistan mountain elevation correction
        // - Maghrib: Astro sunset + 4 min dusk twilight
        // - Isha: Maghrib + 75 min (Kurdistan Awqaf fixed twilight standard)
        let dhuhrMinutes = solarNoonMinutes + 6.0
        let sunriseMinutes = astroSunriseMinutes + 6.0

        let fajrHA = hourAngle(zenithDegrees: 90.0 + 19.5)
        let rawFajrMinutes = fajrHA.isNaN ? (astroSunriseMinutes - 86.0) : (solarNoonMinutes - (fajrHA * 4.0))
        let fajrMinutes = rawFajrMinutes + 13.0

        let asrHA = asrHourAngle(shadowFactor: 1.0)
        let asrMinutes = solarNoonMinutes + (asrHA * 4.0) - 2.0

        let maghribMinutes = astroSunsetMinutes + 4.0
        let ishaMinutes = maghribMinutes + 75.0

        func minutesToDate(_ mins: Double) -> Date {
            let startOfDay = cal.startOfDay(for: date)
            return startOfDay.addingTimeInterval(mins * 60.0)
        }

        return NativePrayerTimes(
            fajr: minutesToDate(fajrMinutes),
            sunrise: minutesToDate(sunriseMinutes),
            dhuhr: minutesToDate(dhuhrMinutes),
            asr: minutesToDate(asrMinutes),
            maghrib: minutesToDate(maghribMinutes),
            isha: minutesToDate(ishaMinutes)
        )
    }

    static func formatCleanTime(_ date: Date) -> String {
        let cal = Calendar.current
        let hour24 = cal.component(.hour, from: date)
        let minute = cal.component(.minute, from: date)
        let hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12
        return String(format: "%02d:%02d", hour12, minute)
    }

    static func formatFullTime(_ date: Date) -> String {
        let cal = Calendar.current
        let hour24 = cal.component(.hour, from: date)
        let minute = cal.component(.minute, from: date)
        let hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12
        let period = hour24 >= 12 ? "PM" : "AM"
        return String(format: "%02d:%02d %@", hour12, minute, period)
    }
}

// MARK: - Widget City Catalog & Location Fallback System

struct WidgetCity: Identifiable, Equatable {
    let id: String
    let nameKu: String
    let nameAr: String
    let nameEn: String
    let latitude: Double
    let longitude: Double

    func displayName(isKurdish: Bool, isArabic: Bool) -> String {
        if isKurdish { return nameKu }
        if isArabic { return nameAr }
        return nameEn
    }
}

enum WidgetCityRegistry {
    static let cities: [WidgetCity] = [
        WidgetCity(id: "Hawler",      nameKu: "هەولێر",       nameAr: "أربيل",       nameEn: "Erbil",        latitude: 36.1911, longitude: 44.0092),
        WidgetCity(id: "Slemani",     nameKu: "سلێمانی",      nameAr: "السليمانية",   nameEn: "Sulaymaniyah", latitude: 35.5570, longitude: 45.4351),
        WidgetCity(id: "Duhok",       nameKu: "دهۆک",        nameAr: "دهوك",        nameEn: "Duhok",        latitude: 36.8617, longitude: 42.9992),
        WidgetCity(id: "Kirkuk",      nameKu: "کەرکووک",      nameAr: "كركوك",       nameEn: "Kirkuk",       latitude: 35.4681, longitude: 44.3922),
        WidgetCity(id: "Halabja",     nameKu: "هەڵەبجە",      nameAr: "حلبجة",       nameEn: "Halabja",      latitude: 35.1778, longitude: 45.9861),
        WidgetCity(id: "Zakho",       nameKu: "زاخۆ",        nameAr: "زاخو",        nameEn: "Zakho",        latitude: 37.1445, longitude: 42.6872),
        WidgetCity(id: "Kalar",       nameKu: "کەلار",        nameAr: "كلار",        nameEn: "Kalar",        latitude: 34.6294, longitude: 45.3169),
        WidgetCity(id: "Rania",       nameKu: "ڕانیە",        nameAr: "رانية",       nameEn: "Rania",        latitude: 36.2547, longitude: 44.8825),
        WidgetCity(id: "Chamchamal",  nameKu: "چەمچەماڵ",     nameAr: "جمجمال",      nameEn: "Chamchamal",   latitude: 35.5317, longitude: 44.8344),
        WidgetCity(id: "Koya",        nameKu: "کۆیە",         nameAr: "كويسنجق",     nameEn: "Koya",         latitude: 36.0828, longitude: 44.6289),
        WidgetCity(id: "Soran",       nameKu: "سۆران",        nameAr: "سوران",       nameEn: "Soran",        latitude: 36.6500, longitude: 44.5386),
        WidgetCity(id: "Akre",        nameKu: "ئاکرێ",        nameAr: "عقرة",        nameEn: "Akre",         latitude: 36.7411, longitude: 43.8933),
        WidgetCity(id: "SaidSadiq",   nameKu: "سەید سادق",    nameAr: "سيد صادق",    nameEn: "Said Sadiq",   latitude: 35.3558, longitude: 45.8642),
        WidgetCity(id: "Derbendikhan",nameKu: "دەربەندیخان",  nameAr: "دربندخان",    nameEn: "Derbendikhan", latitude: 35.1114, longitude: 45.6961),
        WidgetCity(id: "Qaladiza",    nameKu: "قەڵادزێ",      nameAr: "قلعة دزة",    nameEn: "Qaladiza",     latitude: 36.1808, longitude: 45.1228),
        WidgetCity(id: "Shaqlawa",    nameKu: "شەقڵاوە",      nameAr: "شقلاوة",      nameEn: "Shaqlawa",     latitude: 36.4042, longitude: 44.3267),
        WidgetCity(id: "Amadiya",     nameKu: "ئامێدی",       nameAr: "العمادية",    nameEn: "Amadiya",      latitude: 37.0917, longitude: 43.4878),
        WidgetCity(id: "Baghdad",     nameKu: "بەغدا",        nameAr: "بغداد",       nameEn: "Baghdad",      latitude: 33.3152, longitude: 44.3661),
        WidgetCity(id: "Mosul",       nameKu: "موسڵ",         nameAr: "الموصل",      nameEn: "Mosul",        latitude: 36.3350, longitude: 43.1189)
    ]

    static func city(byId id: String?) -> WidgetCity? {
        guard let id = id?.trimmingCharacters(in: .whitespacesAndNewlines), !id.isEmpty else { return nil }
        return cities.first { $0.id.caseInsensitiveCompare(id) == .orderedSame }
    }

    static func city(byName name: String?) -> WidgetCity? {
        guard let name = name?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else { return nil }
        return cities.first {
            $0.nameKu == name || $0.nameAr == name || $0.nameEn.caseInsensitiveCompare(name) == .orderedSame
        }
    }

    static func closestCity(lat: Double, lng: Double) -> WidgetCity? {
        var minDistance = Double.greatestFiniteMagnitude
        var bestCity: WidgetCity? = nil
        for c in cities {
            let dist = distanceInKm(lat1: lat, lon1: lng, lat2: c.latitude, lon2: c.longitude)
            if dist < minDistance {
                minDistance = dist
                bestCity = c
            }
        }
        if minDistance <= 150.0 {
            return bestCity
        }
        return nil
    }

    private static func distanceInKm(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let r = 6371.0
        let dLat = (lat2 - lat1) * .pi / 180.0
        let dLon = (lon2 - lon1) * .pi / 180.0
        let a = sin(dLat / 2) * sin(dLat / 2) +
                cos(lat1 * .pi / 180.0) * cos(lat2 * .pi / 180.0) *
                sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        return r * c
    }

    static func cycleNextCity() {
        let currentCityId = UserDefaults.standard.string(forKey: "widget_selected_city_id")
        let currentIndex = cities.firstIndex { $0.id == currentCityId } ?? 0
        let nextIndex = (currentIndex + 1) % cities.count
        let nextCity = cities[nextIndex]
        UserDefaults.standard.set(nextCity.id, forKey: "widget_selected_city_id")
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "widget_city_selected_time")
    }

    static func getActiveCity(allPrefs: [UserDefaults?]) -> WidgetCity {
        // 1. Check local widget explicit user selection (Highest priority on sideloaded devices)
        if let localSelectedId = UserDefaults.standard.string(forKey: "widget_selected_city_id"),
           let localCity = city(byId: localSelectedId) {
            return localCity
        }

        // 2. Check App Group shared preferences (if working / paid cert / TrollStore)
        for pref in allPrefs {
            guard let p = pref else { continue }
            if let cityId = p.string(forKey: "city_id"), let found = city(byId: cityId) {
                return found
            }
            if let cityName = p.string(forKey: "city_name"), let found = city(byName: cityName) {
                return found
            }
        }

        // 3. Check GPS location (NSWidgetWantsLocation)
        let locManager = CLLocationManager()
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            if let coord = locManager.location?.coordinate,
               let nearest = closestCity(lat: coord.latitude, lng: coord.longitude) {
                return nearest
            }
        }

        // 4. Default: Hawler (Erbil)
        return cities[0]
    }
}

#if canImport(AppIntents)
@available(iOS 16.0, *)
struct SwitchWidgetCityIntent: AppIntent {
    static var title: LocalizedStringResource = "Switch Prayer City"
    static var description = IntentDescription("Cycles to the next Kurdistan city for prayer times")

    init() {}

    func perform() async throws -> some IntentResult {
        WidgetCityRegistry.cycleNextCity()
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
#endif

// MARK: - Interactive City Switcher Buttons

struct CitySwitchButton: View {
    let cityName: String
    let theme: ThemeColors
    let fontSize: CGFloat
    let iconSize: CGFloat
    let showBadge: Bool

    var body: some View {
        #if canImport(AppIntents)
        if #available(iOS 17.0, *) {
            Button(intent: SwitchWidgetCityIntent()) {
                content
            }
            .buttonStyle(.plain)
        } else {
            content
        }
        #else
        content
        #endif
    }

    private var content: some View {
        HStack(spacing: 3.5) {
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: iconSize))
                .foregroundColor(theme.primary)
            Text(cityName)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundColor(theme.secondary)
                .lineLimit(1)
            Image(systemName: "arrow.triangle.2.circlepath")
                .font(.system(size: max(8, iconSize - 4), weight: .bold))
                .foregroundColor(theme.primary.opacity(0.85))
        }
        .padding(.horizontal, showBadge ? 6 : 0)
        .padding(.vertical, showBadge ? 2.5 : 0)
        .background(showBadge ? theme.cardBackground.opacity(0.4) : Color.clear)
        .clipShape(Capsule())
    }
}

struct CitySwitchButtonLockScreen: View {
    let cityName: String

    var body: some View {
        #if canImport(AppIntents)
        if #available(iOS 17.0, *) {
            Button(intent: SwitchWidgetCityIntent()) {
                content
            }
            .buttonStyle(.plain)
        } else {
            content
        }
        #else
        content
        #endif
    }

    private var content: some View {
        HStack(spacing: 2) {
            Text("• \(cityName)")
                .font(.system(size: 8.5, weight: .semibold))
                .lineLimit(1)
            Image(systemName: "arrow.triangle.2.circlepath")
                .font(.system(size: 7, weight: .bold))
        }
        .foregroundColor(.secondary)
    }
}

// MARK: - Timeline Provider

struct PrayerTimelineProvider: TimelineProvider {

    private func readString(_ prefs: [UserDefaults?], keys: [String]) -> String? {
        for pref in prefs {
            guard let p = pref else { continue }
            for key in keys {
                if let value = p.string(forKey: key)?.trimmingCharacters(in: .whitespacesAndNewlines),
                   !value.isEmpty, value != "--:--" {
                    return value
                }
            }
        }
        return nil
    }

    private func readDouble(_ prefs: [UserDefaults?], keys: [String]) -> Double? {
        for pref in prefs {
            guard let p = pref else { continue }
            for key in keys {
                let val = p.double(forKey: key)
                if val > 0 { return val }
                if let str = p.string(forKey: key)?.trimmingCharacters(in: .whitespacesAndNewlines),
                   let d = Double(str), d > 0 {
                    return d
                }
            }
        }
        return nil
    }

    private func parseTimeToDate(_ timeStr: String?, for baseDate: Date, isPMDefault: Bool = false) -> Date? {
        guard let raw = timeStr?.trimmingCharacters(in: .whitespacesAndNewlines),
              !raw.isEmpty, raw != "--:--" else {
            return nil
        }
        let cal = Calendar.current
        let parts = raw.components(separatedBy: " ")
        let timePart = parts.first ?? raw
        let periodPart = parts.count > 1 ? parts[1].uppercased() : nil
        let comps = timePart.components(separatedBy: ":")
        guard comps.count >= 2, let h = Int(comps[0]), let m = Int(comps[1]) else { return nil }

        var hour24 = h
        if let period = periodPart {
            if period == "PM" && hour24 < 12 { hour24 += 12 }
            if period == "AM" && hour24 == 12 { hour24 = 0 }
        } else if isPMDefault && hour24 < 12 {
            hour24 += 12
        }

        var dateComps = cal.dateComponents([.year, .month, .day], from: baseDate)
        dateComps.hour = hour24
        dateComps.minute = m
        dateComps.second = 0
        return cal.date(from: dateComps)
    }

    func placeholder(in context: Context) -> PrayerEntry {
        fetchCurrentEntry(for: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (PrayerEntry) -> ()) {
        completion(fetchCurrentEntry(for: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayerEntry>) -> ()) {
        let now = Date()
        let currentEntry = fetchCurrentEntry(for: now)

        let appGroupPrefs = UserDefaults(suiteName: appGroupId)
        let standardPrefs = UserDefaults.standard
        let allPrefs = [appGroupPrefs, standardPrefs]

        let activeCity = WidgetCityRegistry.getActiveCity(allPrefs: allPrefs)

        let appGroupCityId = readString(allPrefs, keys: ["city_id", "widget_selected_city_id"])
        let appGroupCityName = readString(allPrefs, keys: ["city_name", "city_name_ku", "city_name_en", "city_name_ar"])
        let isAppGroupCityMatch = (appGroupCityId != nil && appGroupCityId?.caseInsensitiveCompare(activeCity.id) == .orderedSame) ||
                                  (appGroupCityName != nil && (appGroupCityName == activeCity.nameKu || appGroupCityName == activeCity.nameAr || appGroupCityName?.caseInsensitiveCompare(activeCity.nameEn) == .orderedSame))

        // Build exact transition dates for today using timestamps or parsed full times
        let fajrTimestamp    = readDouble(allPrefs, keys: ["fajr_timestamp", "fajr_timestamp_str"]) ?? 0
        let sunriseTimestamp = readDouble(allPrefs, keys: ["sunrise_timestamp", "sunrise_timestamp_str"]) ?? 0
        let dhuhrTimestamp   = readDouble(allPrefs, keys: ["dhuhr_timestamp", "dhuhr_timestamp_str"]) ?? 0
        let asrTimestamp     = readDouble(allPrefs, keys: ["asr_timestamp", "asr_timestamp_str"]) ?? 0
        let maghribTimestamp = readDouble(allPrefs, keys: ["maghrib_timestamp", "maghrib_timestamp_str"]) ?? 0
        let ishaTimestamp    = readDouble(allPrefs, keys: ["isha_timestamp", "isha_timestamp_str"]) ?? 0

        var transitionDates: [Date] = []
        if isAppGroupCityMatch && fajrTimestamp > 0 && ishaTimestamp > 0 {
            transitionDates = [
                Date(timeIntervalSince1970: fajrTimestamp),
                Date(timeIntervalSince1970: sunriseTimestamp),
                Date(timeIntervalSince1970: dhuhrTimestamp),
                Date(timeIntervalSince1970: asrTimestamp),
                Date(timeIntervalSince1970: maghribTimestamp),
                Date(timeIntervalSince1970: ishaTimestamp)
            ]
        } else if isAppGroupCityMatch,
                  let pFajr = parseTimeToDate(readString(allPrefs, keys: ["fajr_full_time", "fajr_time"]), for: now, isPMDefault: false),
                  let pSunrise = parseTimeToDate(readString(allPrefs, keys: ["sunrise_full_time", "sunrise_time"]), for: now, isPMDefault: false),
                  let pDhuhr = parseTimeToDate(readString(allPrefs, keys: ["dhuhr_full_time", "dhuhr_time"]), for: now, isPMDefault: false),
                  let pAsr = parseTimeToDate(readString(allPrefs, keys: ["asr_full_time", "asr_time"]), for: now, isPMDefault: true),
                  let pMaghrib = parseTimeToDate(readString(allPrefs, keys: ["maghrib_full_time", "maghrib_time"]), for: now, isPMDefault: true),
                  let pIsha = parseTimeToDate(readString(allPrefs, keys: ["isha_full_time", "isha_time"]), for: now, isPMDefault: true) {
            transitionDates = [pFajr, pSunrise, pDhuhr, pAsr, pMaghrib, pIsha]
        } else {
            let calculated = NativePrayerCalculator.calculate(
                date: now,
                latitude: activeCity.latitude,
                longitude: activeCity.longitude
            )
            transitionDates = [
                calculated.fajr,
                calculated.sunrise,
                calculated.dhuhr,
                calculated.asr,
                calculated.maghrib,
                calculated.isha
            ]
        }

        // Only transitions in the future today (+1 second past azan so card immediately updates)
        let futureTransitionDates = transitionDates
            .filter { $0 > now }
            .map { $0.addingTimeInterval(1) }
            .sorted()

        // Build dynamic entries for each transition point
        var entries: [PrayerEntry] = [currentEntry]
        for tDate in futureTransitionDates.prefix(6) {
            entries.append(fetchCurrentEntry(for: tDate))
        }

        let nextPolicyDate = futureTransitionDates.first ?? now.addingTimeInterval(900)
        let timeline = Timeline(entries: entries, policy: .after(nextPolicyDate))
        completion(timeline)
    }

    private func fetchCurrentEntry(for targetDate: Date = Date()) -> PrayerEntry {
        let appGroupPrefs = UserDefaults(suiteName: appGroupId)
        let standardPrefs = UserDefaults.standard
        let allPrefs = [appGroupPrefs, standardPrefs]

        let lang = readString(allPrefs, keys: ["lang"]) ?? "ku"
        let isKurdish = lang == "ku" || lang == "kmr"
        let isArabic  = lang == "ar"

        let activeCity = WidgetCityRegistry.getActiveCity(allPrefs: allPrefs)

        let appGroupCityId = readString(allPrefs, keys: ["city_id", "widget_selected_city_id"])
        let appGroupCityName = readString(allPrefs, keys: ["city_name", "city_name_ku", "city_name_en", "city_name_ar"])
        let isAppGroupCityMatch = (appGroupCityId != nil && appGroupCityId?.caseInsensitiveCompare(activeCity.id) == .orderedSame) ||
                                  (appGroupCityName != nil && (appGroupCityName == activeCity.nameKu || appGroupCityName == activeCity.nameAr || appGroupCityName?.caseInsensitiveCompare(activeCity.nameEn) == .orderedSame))

        let sharedFajr    = readString(allPrefs, keys: ["fajr_time"])
        let sharedSunrise = readString(allPrefs, keys: ["sunrise_time"])
        let sharedDhuhr   = readString(allPrefs, keys: ["dhuhr_time"])
        let sharedAsr     = readString(allPrefs, keys: ["asr_time"])
        let sharedMaghrib = readString(allPrefs, keys: ["maghrib_time"])
        let sharedIsha    = readString(allPrefs, keys: ["isha_time"])

        let fajrTimestamp    = readDouble(allPrefs, keys: ["fajr_timestamp", "fajr_timestamp_str"]) ?? 0
        let sunriseTimestamp = readDouble(allPrefs, keys: ["sunrise_timestamp", "sunrise_timestamp_str"]) ?? 0
        let dhuhrTimestamp   = readDouble(allPrefs, keys: ["dhuhr_timestamp", "dhuhr_timestamp_str"]) ?? 0
        let asrTimestamp     = readDouble(allPrefs, keys: ["asr_timestamp", "asr_timestamp_str"]) ?? 0
        let maghribTimestamp = readDouble(allPrefs, keys: ["maghrib_timestamp", "maghrib_timestamp_str"]) ?? 0
        let ishaTimestamp    = readDouble(allPrefs, keys: ["isha_timestamp", "isha_timestamp_str"]) ?? 0

        let hasTimestamps = fajrTimestamp > 0 && sunriseTimestamp > 0 && dhuhrTimestamp > 0 &&
                            asrTimestamp > 0 && maghribTimestamp > 0 && ishaTimestamp > 0

        let fajrDate: Date
        let sunriseDate: Date
        let dhuhrDate: Date
        let asrDate: Date
        let maghribDate: Date
        let ishaDate: Date

        let fajrStr: String
        let sunriseStr: String
        let dhuhrStr: String
        let asrStr: String
        let maghribStr: String
        let ishaStr: String

        if isAppGroupCityMatch && hasTimestamps {
            fajrDate    = Date(timeIntervalSince1970: fajrTimestamp)
            sunriseDate = Date(timeIntervalSince1970: sunriseTimestamp)
            dhuhrDate   = Date(timeIntervalSince1970: dhuhrTimestamp)
            asrDate     = Date(timeIntervalSince1970: asrTimestamp)
            maghribDate = Date(timeIntervalSince1970: maghribTimestamp)
            ishaDate    = Date(timeIntervalSince1970: ishaTimestamp)

            fajrStr    = sharedFajr ?? NativePrayerCalculator.formatCleanTime(fajrDate)
            sunriseStr = sharedSunrise ?? NativePrayerCalculator.formatCleanTime(sunriseDate)
            dhuhrStr   = sharedDhuhr ?? NativePrayerCalculator.formatCleanTime(dhuhrDate)
            asrStr     = sharedAsr ?? NativePrayerCalculator.formatCleanTime(asrDate)
            maghribStr = sharedMaghrib ?? NativePrayerCalculator.formatCleanTime(maghribDate)
            ishaStr    = sharedIsha ?? NativePrayerCalculator.formatCleanTime(ishaDate)
        } else if isAppGroupCityMatch,
                  let pFajr = parseTimeToDate(readString(allPrefs, keys: ["fajr_full_time", "fajr_time"]), for: targetDate, isPMDefault: false),
                  let pSunrise = parseTimeToDate(readString(allPrefs, keys: ["sunrise_full_time", "sunrise_time"]), for: targetDate, isPMDefault: false),
                  let pDhuhr = parseTimeToDate(readString(allPrefs, keys: ["dhuhr_full_time", "dhuhr_time"]), for: targetDate, isPMDefault: false),
                  let pAsr = parseTimeToDate(readString(allPrefs, keys: ["asr_full_time", "asr_time"]), for: targetDate, isPMDefault: true),
                  let pMaghrib = parseTimeToDate(readString(allPrefs, keys: ["maghrib_full_time", "maghrib_time"]), for: targetDate, isPMDefault: true),
                  let pIsha = parseTimeToDate(readString(allPrefs, keys: ["isha_full_time", "isha_time"]), for: targetDate, isPMDefault: true) {
            fajrDate    = pFajr
            sunriseDate = pSunrise
            dhuhrDate   = pDhuhr
            asrDate     = pAsr
            maghribDate = pMaghrib
            ishaDate    = pIsha

            fajrStr    = sharedFajr ?? NativePrayerCalculator.formatCleanTime(fajrDate)
            sunriseStr = sharedSunrise ?? NativePrayerCalculator.formatCleanTime(sunriseDate)
            dhuhrStr   = sharedDhuhr ?? NativePrayerCalculator.formatCleanTime(dhuhrDate)
            asrStr     = sharedAsr ?? NativePrayerCalculator.formatCleanTime(asrDate)
            maghribStr = sharedMaghrib ?? NativePrayerCalculator.formatCleanTime(maghribDate)
            ishaStr    = sharedIsha ?? NativePrayerCalculator.formatCleanTime(ishaDate)
        } else {
            let calculated = NativePrayerCalculator.calculate(
                date: targetDate,
                latitude: activeCity.latitude,
                longitude: activeCity.longitude
            )
            fajrDate    = calculated.fajr
            sunriseDate = calculated.sunrise
            dhuhrDate   = calculated.dhuhr
            asrDate     = calculated.asr
            maghribDate = calculated.maghrib
            ishaDate    = calculated.isha

            fajrStr    = NativePrayerCalculator.formatCleanTime(fajrDate)
            sunriseStr = NativePrayerCalculator.formatCleanTime(sunriseDate)
            dhuhrStr   = NativePrayerCalculator.formatCleanTime(dhuhrDate)
            asrStr     = NativePrayerCalculator.formatCleanTime(asrDate)
            maghribStr = NativePrayerCalculator.formatCleanTime(maghribDate)
            ishaStr    = NativePrayerCalculator.formatCleanTime(ishaDate)
        }

        // Determine which prayer is next relative to targetDate
        let nextId: String
        let nextName: String
        let nextFullTime: String
        let nextTimestamp: Double

        if targetDate < fajrDate {
            nextId = "fajr"
            nextName = isKurdish ? "بانگی بەیانی" : (isArabic ? "صلاة الفجر" : "Fajr")
            nextFullTime = (isAppGroupCityMatch ? readString(allPrefs, keys: ["fajr_full_time"]) : nil) ?? NativePrayerCalculator.formatFullTime(fajrDate)
            nextTimestamp = fajrDate.timeIntervalSince1970
        } else if targetDate < sunriseDate {
            nextId = "sunrise"
            nextName = isKurdish ? "هەڵاتنی خۆر" : (isArabic ? "الشروق" : "Sunrise")
            nextFullTime = (isAppGroupCityMatch ? readString(allPrefs, keys: ["sunrise_full_time"]) : nil) ?? NativePrayerCalculator.formatFullTime(sunriseDate)
            nextTimestamp = sunriseDate.timeIntervalSince1970
        } else if targetDate < dhuhrDate {
            nextId = "dhuhr"
            nextName = isKurdish ? "بانگی نیوەڕۆ" : (isArabic ? "صلاة الظهر" : "Dhuhr")
            nextFullTime = (isAppGroupCityMatch ? readString(allPrefs, keys: ["dhuhr_full_time"]) : nil) ?? NativePrayerCalculator.formatFullTime(dhuhrDate)
            nextTimestamp = dhuhrDate.timeIntervalSince1970
        } else if targetDate < asrDate {
            nextId = "asr"
            nextName = isKurdish ? "بانگی عەسر" : (isArabic ? "صلاة العصر" : "Asr")
            nextFullTime = (isAppGroupCityMatch ? readString(allPrefs, keys: ["asr_full_time"]) : nil) ?? NativePrayerCalculator.formatFullTime(asrDate)
            nextTimestamp = asrDate.timeIntervalSince1970
        } else if targetDate < maghribDate {
            nextId = "maghrib"
            nextName = isKurdish ? "بانگی شێوان" : (isArabic ? "صلاة المغرب" : "Maghrib")
            nextFullTime = (isAppGroupCityMatch ? readString(allPrefs, keys: ["maghrib_full_time"]) : nil) ?? NativePrayerCalculator.formatFullTime(maghribDate)
            nextTimestamp = maghribDate.timeIntervalSince1970
        } else if targetDate < ishaDate {
            nextId = "isha"
            nextName = isKurdish ? "بانگی خەوتنان" : (isArabic ? "صلاة العشاء" : "Isha")
            nextFullTime = (isAppGroupCityMatch ? readString(allPrefs, keys: ["isha_full_time"]) : nil) ?? NativePrayerCalculator.formatFullTime(ishaDate)
            nextTimestamp = ishaDate.timeIntervalSince1970
        } else {
            // All prayers passed for today — next prayer is tomorrow's Fajr
            let tomorrowFajrDate = fajrDate.addingTimeInterval(86400)
            nextId = "fajr"
            nextName = isKurdish ? "بانگی بەیانی" : (isArabic ? "صلاة الفجر" : "Fajr")
            nextFullTime = NativePrayerCalculator.formatFullTime(tomorrowFajrDate)
            nextTimestamp = tomorrowFajrDate.timeIntervalSince1970
        }

        let cityName = activeCity.displayName(isKurdish: isKurdish, isArabic: isArabic)
        let hijriDate = readString(allPrefs, keys: ["hijri_date"]) ?? IslamicDateHelper.format(date: targetDate, isKurdish: isKurdish, isArabic: isArabic)
        let themeKey = readString(allPrefs, keys: ["theme_key"]) ?? "nuri"

        return PrayerEntry(
            date: targetDate,
            cityName: cityName,
            hijriDate: hijriDate,
            nextPrayerName: nextName,
            nextPrayerTime: nextFullTime,
            nextPrayerTimestamp: nextTimestamp,
            nextPrayerId: nextId,
            fajr: fajrStr,
            sunrise: sunriseStr,
            dhuhr: dhuhrStr,
            asr: asrStr,
            maghrib: maghribStr,
            isha: ishaStr,
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
        Group {
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
        .widgetURL(URL(string: "nadazikr://prayer-times"))
    }

    // MARK: - Small Widget (Balanced, Compact, No Dead Space)
    var smallWidget: some View {
        VStack(spacing: 4) {
            // Top Header: City & Pin + App Title
            HStack(alignment: .center) {
                CitySwitchButton(cityName: entry.cityName, theme: theme, fontSize: 11, iconSize: 11, showBadge: false)
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
                // Right (in RTL): City + Pin + Switcher
                CitySwitchButton(cityName: entry.cityName, theme: theme, fontSize: 12.5, iconSize: 13, showBadge: true)

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
                CitySwitchButton(cityName: entry.cityName, theme: theme, fontSize: 14, iconSize: 14, showBadge: true)
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

    private func shortPrayerName(_ slot: PrayerSlot) -> String {
        switch slot.id {
        case "fajr":
            return entry.isKurdish ? "بەیانی" : (entry.isArabic ? "فجر" : "Fajr")
        case "sunrise":
            return entry.isKurdish ? "خۆر" : (entry.isArabic ? "شروق" : "Sun")
        case "dhuhr":
            return entry.isKurdish ? "نیوەڕۆ" : (entry.isArabic ? "ظهر" : "Dhuhr")
        case "asr":
            return entry.isKurdish ? "عەسر" : (entry.isArabic ? "عصر" : "Asr")
        case "maghrib":
            return entry.isKurdish ? "شێوان" : (entry.isArabic ? "مغرب" : "Magh")
        case "isha":
            return entry.isKurdish ? "خەوتنان" : (entry.isArabic ? "عشاء" : "Isha")
        default:
            return prayerName(slot)
        }
    }

    // MARK: - Lock Screen Widgets (iOS 16+, No Emojis)

    @available(iOSApplicationExtension 16.0, *)
    var lockScreenRectangular: some View {
        VStack(alignment: .leading, spacing: 3) {
            // Header Row: Next Prayer Name + Time + City Indicator + Live Countdown Timer
            HStack(alignment: .firstTextBaseline) {
                HStack(spacing: 3) {
                    if let nextSlot = prayerSlots().first(where: { $0.isNext }) {
                        Image(systemName: nextSlot.iconName)
                            .font(.system(size: 10, weight: .bold))
                    }
                    Text(cleanNextPrayerName)
                        .font(.system(size: 11, weight: .bold))
                        .lineLimit(1)
                    Text(cleanTime(entry.nextPrayerTime))
                        .font(.system(size: 12.5, weight: .heavy, design: .rounded))
                        .lineLimit(1)
                    if !entry.cityName.isEmpty {
                        CitySwitchButtonLockScreen(cityName: entry.cityName)
                    }
                }
                Spacer()
                if let target = entry.nextPrayerDate, target > Date() {
                    Text(target, style: .timer)
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .lineLimit(1)
                } else if !entry.liveRemainingText.isEmpty {
                    Text(entry.liveRemainingText)
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }

            // Subtle divider
            Rectangle()
                .fill(Color.secondary.opacity(0.3))
                .frame(height: 0.5)

            // Bottom Grid: All 6 Prayer Times (Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha)
            HStack(spacing: 1.5) {
                let slots = prayerSlots()
                ForEach(slots) { slot in
                    VStack(spacing: 1) {
                        Text(shortPrayerName(slot))
                            .font(.system(size: 7.5, weight: slot.isNext ? .bold : .medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                        Text(cleanTime(slot.time))
                            .font(.system(size: 8.5, weight: slot.isNext ? .heavy : .regular, design: .monospaced))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 1.5)
                    .background(slot.isNext ? Color.white.opacity(0.22) : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 3.5, style: .continuous))
                }
            }
        }
        .environment(\.layoutDirection, (entry.isKurdish || entry.isArabic) ? .rightToLeft : .leftToRight)
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
