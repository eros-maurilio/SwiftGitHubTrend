struct CellDTO {
    
    let repoName: String
    let repoDescription: String
    let authorName: String
    let authorPicUrl: String
    let date: String?
    let starsCount: Int?
    let forksCount: Int?
    
    init(repoName: String, repoDescription: String, authorName: String, authorPicUrl: String, date: String? = nil, starsCount: Int? = nil, forksCount: Int? = nil) {
        self.repoName = repoName
        self.repoDescription = repoDescription
        self.authorName = authorName
        self.authorPicUrl = authorPicUrl
        self.date = date
        self.starsCount = starsCount
        self.forksCount = forksCount
    }
}
