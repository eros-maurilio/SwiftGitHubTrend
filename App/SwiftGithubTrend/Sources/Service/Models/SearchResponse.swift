struct SearchResponse: Codable {
    let items: [Item]
}

struct Item: Codable {
    let repoName: String
    let repoPath: String
    let repoDescription: String?
    let owner: Owner
    let starsCount: Int
    let forksCount: Int
}

private extension Item {
    enum CodingKeys: String, CodingKey {
        case repoName = "name"
        case repoPath = "full_name"
        case repoDescription = "description"
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
        case owner
    }
}
