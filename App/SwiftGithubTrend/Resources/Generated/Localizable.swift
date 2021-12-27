// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localizable {

  internal enum Github {
    /// api.github.com
    internal static let host = Localizable.tr("Localizable", "Github.host")
    internal enum Path {
      /// /repos
      internal static let repos = Localizable.tr("Localizable", "Github.path.repos")
      /// /search/repositories
      internal static let search = Localizable.tr("Localizable", "Github.path.search")
    }
  }

  internal enum Web {
    /// https
    internal static let https = Localizable.tr("Localizable", "Web.https")
  }

  internal enum Query {
    internal enum Item {
      /// q
      internal static let letter = Localizable.tr("Localizable", "query.item.letter")
      /// sorting
      internal static let sorting = Localizable.tr("Localizable", "query.item.sorting")
    }
  }

  internal enum Test {
    /// A random test
    internal static let text = Localizable.tr("Localizable", "test.text")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localizable {
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
