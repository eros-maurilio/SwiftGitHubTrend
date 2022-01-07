struct WatchResponse: Codable {
    let title: String?
    let head: Head
    let body: String?
}

struct Head: Codable {
    let repo: Repo

}

struct Repo: Codable {
    let owner: Owner
    let createdAt: String
}

extension Repo {
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case owner
    }
}
