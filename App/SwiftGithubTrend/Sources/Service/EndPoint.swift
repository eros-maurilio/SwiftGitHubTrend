import Foundation

struct EndPoint {
    let path: String
    let queryItems: [URLQueryItem]?
    let repo: String?
    
    init(path: String, queryItems: [URLQueryItem]? = nil, repo: String? = nil) {
        self.path = path
        self.queryItems = queryItems
        self.repo = repo
    }

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
        return EndPoint(path: Localizable.Github.Path.search,
                        queryItems: [
                            URLQueryItem(name: Localizable.Query.Item.letter, value: query),
                            URLQueryItem(name: Localizable.Query.Item.sorting, value: sorting)
                        ]
        )
    }
    
    static func watch(repo repoName: String, from author: String, listedBy: String) -> EndPoint {
        let repoPath = repoPath([repoName, author, listedBy])
        
        return EndPoint(path: repoPath)
        
    }
    
    private static func repoPath(_ parameters: [String]) -> String {
        var path = Localizable.Github.Path.repos
        
        for parameter in parameters {
            path += parameter.insertSlash(in: parameter)
        }
        
        return path
    }
}
