struct CellDTO {
    
    let title: String
    let description: String
    let authorName: String
    let authorPicUrl: String
    let date: String?
    let starsCount: Int?
    let forksCount: Int?
    
    init(title: String, description: String, authorName: String, authorPicUrl: String, date: String? = nil, starsCount: Int? = nil, forksCount: Int? = nil) {
        self.title = title
        self.description = description
        self.authorName = authorName
        self.authorPicUrl = authorPicUrl
        self.date = date
        self.starsCount = starsCount
        self.forksCount = forksCount
    }
}
