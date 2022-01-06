import UIKit

struct CellDTO {
    let repoName: String
    let repoDescription: String
    
    // Add other repo infos here
}

class RepositorieViewCell: UITableViewCell {
    @IBOutlet private weak var repoName: UILabel!
    @IBOutlet private weak var repoDescription: UILabel!
    @IBOutlet weak var outline: UIView!
    
}

extension RepositorieViewCell {
    func fill(dto: CellDTO) {
        repoName.text = dto.repoName
        repoDescription.text = dto.repoDescription
        styleCell()
        //Add other repo infos gere
    }
    
    private func styleCell() {
        outline.layer.cornerRadius = 10
        outline.layer.borderWidth = 1
        outline.layer.borderColor = UIColor.secondarySystemFill.cgColor
    }
}
