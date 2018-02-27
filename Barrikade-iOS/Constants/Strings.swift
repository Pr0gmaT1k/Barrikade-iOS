// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// BARRIKADE
  static let navbarMainTitle = L10n.tr("Localizable", "navbar_main_title")
  /// <html><head><link rel="stylesheet" href="bootstrap.min.css"</head><body>%@</body></html>
  static func newsDetailsHtml(_ p1: String) -> String {
    return L10n.tr("Localizable", "news_details_html", p1)
  }
  /// AGENDA
  static let pageMenuAgenda = L10n.tr("Localizable", "page_menu_agenda")
  /// AKTUEL
  static let pageMenuAktuel = L10n.tr("Localizable", "page_menu_aktuel")
  /// ANALYSE
  static let pageMenuAnalyses = L10n.tr("Localizable", "page_menu_analyses")
  /// GLOBALE INFOS
  static let pageMenuGlobaleInfos = L10n.tr("Localizable", "page_menu_globale_infos")
  /// LOKALE INFOS
  static let pageMenuLocalInfos = L10n.tr("Localizable", "page_menu_local_infos")
  /// Artikel zu synchronisieren : 
  static let syncMessageArticleToSync = L10n.tr("Localizable", "sync_message_article_to_sync")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
