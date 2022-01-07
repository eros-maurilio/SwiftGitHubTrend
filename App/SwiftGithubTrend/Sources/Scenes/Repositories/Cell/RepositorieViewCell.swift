import UIKit

struct CellDTO {
    let repoName: String
    let repoDescription: String
    let authorName: String
    let starsCount: Int
    let forksCount: Int
    
    // Add other repo infos here
}

class RepositorieViewCell: UITableViewCell {
    @IBOutlet private weak var repoName: UILabel!
    @IBOutlet private weak var repoDescription: UILabel!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var stars: UILabel!
    @IBOutlet private weak var forks: UILabel!
    @IBOutlet private weak var outline: UIView!
    @IBOutlet private weak var authorPic: UIImageView!
}

extension RepositorieViewCell {
    func fill(dto: CellDTO) {
        authorName.text = dto.authorName
        repoName.text = dto.repoName
        repoDescription.text = dto.repoDescription
        stars.text = String(dto.starsCount)
        forks.text = String(dto.forksCount)
        
        styleCell()
    }
    
    private func styleCell() {
        outline.layer.cornerRadius = 10
        outline.layer.borderWidth = 1
        outline.layer.borderColor = UIColor.secondarySystemFill.cgColor
        
        authorPic.layer.cornerRadius = CGFloat(authorPic.frame.height / 2)
    }
}
