// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Wystąpił problem z przetwarzaniem Twojego żądania. Upewnij się, że masz połączenie z Internetem lub spróbuj za chwilę.
  internal static let errorPlaceholder = L10n.tr("Localizable", "error_placeholder")
  /// Dodaj przystanki do ulubionych, żeby sprawdzać je bez wyszukiwania.
  internal static let favoritePlaceholder = L10n.tr("Localizable", "favorite_placeholder")
  /// Odjeżdża!
  internal static let isDrivingAway = L10n.tr("Localizable", "is_driving_away")
  /// %d min
  internal static func minutesFormat(_ p1: Int) -> String {
    return L10n.tr("Localizable", "minutes_format", p1)
  }
  /// Nie możemy znaleźć tego, czego szukasz. Sprawdź, czy Twoje zapytanie jest poprawne.
  internal static let searchNoResultPlaceholder = L10n.tr("Localizable", "search_no_result_placeholder")
  /// Wyszukaj przystanek, linię lub ulicę i sprawdź, kiedy odjedzie Twój autobus lub\ntramwaj.
  internal static let searchPlaceholder = L10n.tr("Localizable", "search_placeholder")
  /// Moje przystanki
  internal static let tabFavorites = L10n.tr("Localizable", "tab_favorites")
  /// Mapa
  internal static let tabMap = L10n.tr("Localizable", "tab_map")
  /// Wyszukaj
  internal static let tabSearch = L10n.tr("Localizable", "tab_search")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
