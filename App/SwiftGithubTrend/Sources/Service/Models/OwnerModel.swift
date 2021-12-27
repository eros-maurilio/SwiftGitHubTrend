struct Owner: Codable {
    let login: String
    let avatarUrl: String
}

private extension Owner {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login
    }
}
