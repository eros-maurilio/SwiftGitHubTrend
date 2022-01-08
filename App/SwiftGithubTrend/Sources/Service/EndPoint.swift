import Foundation

struct EndPoint {
    
    // MARK: - Atributes
    
    let path: String
    let queryItems: [URLQueryItem]?
    let repo: String?
    
    // MARK: - Computed Variable URL
    
    var url: URL? {
        
        var components = URLComponents()
        components.scheme = Strings.Web.https
        components.host = Strings.Github.host
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
            URLQueryItem(name: Strings.Query.Item.letter, value: query),
            URLQueryItem(name: Strings.Query.Item.sorting, value: sorting),
            URLQueryItem(name: Strings.Query.Item.page, value: page)
        ]
        
        return EndPoint(path: Strings.Github.Path.search, queryItems: queryItems)
        
    }
    
    static func watch(repo repoSelectedPath: String, listedBy: String) -> EndPoint {
        let repoPath = repoPathFactory(using: repoSelectedPath, and: listedBy)
        
        return EndPoint(path: repoPath)
        
    }
    
    // MARK: - Helper Method
    
    private static func repoPathFactory(using parameter: String, and listedBy: String) -> String {
        var path = Strings.Github.Path.repos
        let items = [parameter, listedBy]
        
        for item in items {
            path += item.insertSlash(in: item)
        }
    
        return path
    }
}
