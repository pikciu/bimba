// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add to favorites
  internal static let addToFavorites = L10n.tr("Localizable", "add_to_favorites")
  /// Edit to select a stop
  internal static let editToSelectStop = L10n.tr("Localizable", "edit_to_select_stop")
  /// There was a problem processing your request. Please make sure you are connected to the Internet or try in a moment.
  internal static let errorPlaceholder = L10n.tr("Localizable", "error_placeholder")
  /// Favorite
  internal static let favorite = L10n.tr("Localizable", "favorite")
  /// Add stop to favorite to check it without searching.
  internal static let favoritePlaceholder = L10n.tr("Localizable", "favorite_placeholder")
  /// Favorite stop
  internal static let favoriteStop = L10n.tr("Localizable", "favorite_stop")
  /// Departures from a selected stop.
  internal static let favoriteStopDescription = L10n.tr("Localizable", "favorite_stop_description")
  /// Drives away!
  internal static let isDrivingAway = L10n.tr("Localizable", "is_driving_away")
  /// %d min
  internal static func minutesFormat(_ p1: Int) -> String {
    return L10n.tr("Localizable", "minutes_format", p1)
  }
  /// Nearby
  internal static let nearby = L10n.tr("Localizable", "nearby")
  /// The app doesn't have permission to determine your position.\nEnable location access in iPhone settings to see nearby stops.
  internal static let noLocationPermissionsPlaceholder = L10n.tr("Localizable", "no_location_permissions_placeholder")
  /// Remove from favorites
  internal static let removeFromFavorites = L10n.tr("Localizable", "remove_from_favorites")
  /// We couldn't find what you're looking for. Check if your query is correct.
  internal static let searchNoResultPlaceholder = L10n.tr("Localizable", "search_no_result_placeholder")
  /// Search for stop, line or street to check when your bus or tram is leaving.
  internal static let searchPlaceholder = L10n.tr("Localizable", "search_placeholder")
  /// All
  internal static let searchScopeAll = L10n.tr("Localizable", "search_scope_all")
  /// Line
  internal static let searchScopeLine = L10n.tr("Localizable", "search_scope_line")
  /// Stop
  internal static let searchScopeStopPoint = L10n.tr("Localizable", "search_scope_stop_point")
  /// Street
  internal static let searchScopeStreet = L10n.tr("Localizable", "search_scope_street")
  /// Star
  internal static let star = L10n.tr("Localizable", "star")
  /// My stops
  internal static let tabFavorites = L10n.tr("Localizable", "tab_favorites")
  /// Map
  internal static let tabMap = L10n.tr("Localizable", "tab_map")
  /// Search
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
