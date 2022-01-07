import UIKit
import Kingfisher

struct CellDTO {
    
    let repoName: String
    let repoDescription: String
    let authorName: String
    let authorPicUrl: String
    let starsCount: Int
    let forksCount: Int
    
}

class RepositorieViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var repoName: UILabel!
    @IBOutlet private weak var repoDescription: UILabel!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var stars: UILabel!
    @IBOutlet private weak var forks: UILabel!
    @IBOutlet private weak var outline: UIView!
    @IBOutlet private weak var authorPic: UIImageView!
}

extension RepositorieViewCell {
    
    // MARK: - Public Cell Method
    
    func fill(dto: CellDTO) {
        authorName.text = dto.authorName
        authorPic.kf.setImage(with: URL(string: dto.authorPicUrl))
        repoName.text = dto.repoName
        repoDescription.text = dto.repoDescription
        stars.text = String(dto.starsCount)
        forks.text = String(dto.forksCount)
        styleCell()
    }
    
    func indicator() {
        
    }
    
    // MARK: Private Styling Cell Method
    
    private func styleCell() {
        outline.layer.cornerRadius = Layout.Cell.outlineCornerRadius
        outline.layer.borderWidth = Layout.Cell.outlineBorderWidth
        outline.layer.borderColor = Layout.Cell.outlineBorderColor
        authorPic.layer.cornerRadius = Layout.Cell.cornerRadius(for: authorPic)
    }
}
