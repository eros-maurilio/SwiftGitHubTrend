struct RepoWatch: Codable {
    let title: String
    let head: Head
    let body: String
}

struct Head: Codable {
    let repo: Repo

}

struct Repo: Codable {
    let owner: Owner
    let createAt: String
}

extension Repo {
    enum CodingKeys: String, CodingKey {
        case createAt = "create_at"
        case owner
    }
}
