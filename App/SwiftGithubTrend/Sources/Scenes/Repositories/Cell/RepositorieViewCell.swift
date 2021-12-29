import UIKit

struct CellDTO {
    let repoName: String
    let repoDescription: String
    
    // Add other repo infos here
}

class RepositorieViewCell: UITableViewCell {
    @IBOutlet private weak var repoName: UILabel!
    @IBOutlet private weak var repoDescription: UILabel!
    
}

extension RepositorieViewCell {
    func fill(dto: CellDTO) {
        repoName.text = dto.repoName
        repoDescription.text = dto.repoDescription
        
        //Add other repo infos gere
    }
}
