import Foundation

struct EndPoint {
    
    // MARK: - Atributes
    
    let path: String
    let queryItems: [URLQueryItem]?
    let repo: String?
    
    // MARK: - Computed Variable URL
    
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

    // MARK: - Dependencies
    
    init(path: String, queryItems: [URLQueryItem]? = nil, repo: String? = nil) {
        self.path = path
        self.queryItems = queryItems
        self.repo = repo
    }
}

extension EndPoint {
    
    // MARK: - Main Static Methods
    
    static func findRepositories(using query: String, sortedBy sorting: String, atPage page: String) -> EndPoint {
        let queryItems = [
            URLQueryItem(name: Localizable.Query.Item.letter, value: query),
            URLQueryItem(name: Localizable.Query.Item.sorting, value: sorting),
            URLQueryItem(name: Localizable.Query.Item.page, value: page)
        ]
        
        return EndPoint(path: Localizable.Github.Path.search, queryItems: queryItems)
        
    }
    
    static func watch(repo repoName: String, from author: String, listedBy: String) -> EndPoint {
        let repoPath = repoPathFactory(using: [repoName, author, listedBy])
        
        return EndPoint(path: repoPath)
        
    }
    
    // MARK: - Helper Method
    
    private static func repoPathFactory(using parameters: [String]) -> String {
        var path = Localizable.Github.Path.repos
        
        for parameter in parameters {
            path += parameter.insertSlash(in: parameter)
        }
        
        return path
    }
}
