// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {

  internal enum Api {
    internal enum Response {
      internal enum Description {
        /// No description available
        internal static let empty = Strings.tr("Strings", "Api.response.description.empty")
      }
    }
  }

  internal enum Github {
    /// api.github.com
    internal static let host = Strings.tr("Strings", "Github.host")
    internal enum Parameters {
      internal enum Language {
        /// language:Swift
        internal static let swift = Strings.tr("Strings", "Github.parameters.language.swift")
      }
      internal enum Sorting {
        /// stars
        internal static let stars = Strings.tr("Strings", "Github.parameters.sorting.stars")
      }
    }
    internal enum Path {
      /// /repos
      internal static let repos = Strings.tr("Strings", "Github.path.repos")
      /// /search/repositories
      internal static let search = Strings.tr("Strings", "Github.path.search")
    }
  }

  internal enum Web {
    /// https
    internal static let https = Strings.tr("Strings", "Web.https")
  }

  internal enum Nav {
    internal enum Title {
      /// Swift's Most Popular Repos
      internal static let popSwift = Strings.tr("Strings", "nav.title.popSwift")
    }
  }

  internal enum Query {
    internal enum Item {
      /// q
      internal static let letter = Strings.tr("Strings", "query.item.letter")
      /// pulls
      internal static let listing = Strings.tr("Strings", "query.item.listing")
      /// page
      internal static let page = Strings.tr("Strings", "query.item.page")
      /// sorting
      internal static let sorting = Strings.tr("Strings", "query.item.sorting")
    }
  }

  internal enum Sf {
    internal enum Symbols {
      /// calendar
      internal static let date = Strings.tr("Strings", "sf.symbols.date")
      /// arrow.triangle.pull
      internal static let pull = Strings.tr("Strings", "sf.symbols.pull")
      /// book.closed
      internal static let repo = Strings.tr("Strings", "sf.symbols.repo")
      /// star
      internal static let star = Strings.tr("Strings", "sf.symbols.star")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
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
