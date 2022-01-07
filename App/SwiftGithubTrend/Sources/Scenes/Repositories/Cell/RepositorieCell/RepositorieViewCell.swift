import UIKit
import Down
import Kingfisher

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

class RepositorieViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var repoName: UILabel!
    @IBOutlet private weak var repoDescription: UILabel!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var stars: UILabel!
    @IBOutlet private weak var forks: UILabel!
    @IBOutlet private weak var forkIcon: UIImageView!
    @IBOutlet private weak var outline: UIView!
    @IBOutlet private weak var authorPic: UIImageView!
    @IBOutlet private weak var mainIcon: UIImageView!
    @IBOutlet private weak var bottomIcon: UIImageView!
}

extension RepositorieViewCell {
    
    // MARK: - Public Cell Method
    
    func repoCell(dto: CellDTO) {
        commonStats(with: dto)
        repoDescription.text = dto.repoDescription
        stars.text = String(dto.starsCount!)
        forks.text = String(dto.forksCount!)
        stylingRepositorieCellComponents()
    }

    func pullCell(dto: CellDTO) {
        commonStats(with: dto)
        stars.text = String(dto.date!)
        markRender(dto.repoDescription)
        stylingPullsCellComponents()
    }
    
    // MARK: Private Styling Cell Method
    
    private func styleCell() {
        outline.layer.cornerRadius = Layout.Cell.outlineCornerRadius
        outline.layer.borderWidth = Layout.Cell.outlineBorderWidth
        outline.layer.borderColor = Layout.Cell.outlineBorderColor
        authorPic.layer.cornerRadius = Layout.Cell.cornerRadius(for: authorPic)
    }
    
    private func stylingRepositorieCellComponents() {
        mainIcon.image = UIImage(systemName: "book.closed")
        bottomIcon.image = UIImage(systemName: "star")
        forkIcon.isHidden = false
        forks.isHidden = false
    }
    
    private func stylingPullsCellComponents() {
        mainIcon.image = UIImage(systemName: "arrow.triangle.pull")
        bottomIcon.image = UIImage(systemName: "calendar")
        
        forks.isHidden = true
        forkIcon.isHidden = true
    }
    
    private func markRender(_ body: String) {
        let down = Down(markdownString: body)
        let style = "body { font: 100% sans-serif; color: dimgray; }"
        let atributedString = try? down.toAttributedString(stylesheet: style)
        repoDescription.attributedText = atributedString
    }

    
    private func commonStats(with dto: CellDTO) {
        authorName.text = dto.authorName
        authorPic.kf.setImage(with: URL(string: dto.authorPicUrl))
        repoName.text = dto.repoName
        styleCell()
    }
}
