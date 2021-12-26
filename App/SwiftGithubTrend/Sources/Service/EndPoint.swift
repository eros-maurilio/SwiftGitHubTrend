import Foundation

struct EndPoint {
    let path: String
    let queryItems: [URLQueryItem]?
    let repo: String? = nil

    var url: URL? {

        var components = URLComponents()
        components.scheme = Localizable.Web.https
        components.host = Localizable.Github.host
        components.path = path

        guard let query = queryItems else {
            return components.url
        }

        components.queryItems = query

        return components.url
    }
    
}

extension EndPoint {
    static func findRepositories(using query: String, sortedBy sorting: String) -> EndPoint {
        return EndPoint(path: Localizable.Github.path,
                        queryItems: [
                            URLQueryItem(name: Localizable.Query.Item.letter, value: query),
                            URLQueryItem(name: Localizable.Query.Item.sorting, value: sorting)
                        ]
        )
    }
}
