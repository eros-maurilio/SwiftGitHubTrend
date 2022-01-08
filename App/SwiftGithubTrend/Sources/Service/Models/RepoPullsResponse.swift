struct RepoPullsResponse: Codable {
    let title: String
    let head: Head
    let body: String?
}

struct Head: Codable {
    let repo: Repo
}

struct Repo: Codable {
    let repoName: String
    let owner: Owner
    let createdAt: String
}

extension Repo {
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case repoName = "name"
        case owner
    }
}
