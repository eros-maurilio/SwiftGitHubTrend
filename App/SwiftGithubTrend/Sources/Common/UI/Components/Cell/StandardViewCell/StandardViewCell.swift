import UIKit
import Down
import Kingfisher

class StandardViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var bodyDescription: UILabel!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var stars: UILabel!
    @IBOutlet private weak var forks: UILabel!
    @IBOutlet private weak var forkIcon: UIImageView!
    @IBOutlet private weak var outline: UIView!
    @IBOutlet private weak var authorPic: UIImageView!
    @IBOutlet private weak var mainIcon: UIImageView!
    @IBOutlet private weak var bottomIcon: UIImageView!
    
}

extension StandardViewCell {
    
    // MARK: - Public Cell Method
    
    func selectCellType(of type: CellFactory.CellType, with dto: CellDTO) {
        switch type {
        case .repositories:
            repoCell(dto: dto)
        case .pulls:
            pullCell(dto: dto)
        }
    }
}
    
    // MARK: - Private Methods
    
    private extension StandardViewCell {
        
        func repoCell(dto: CellDTO) {
            commonStats(with: dto)
            bodyDescription.text = dto.description
            
            if let starCount = dto.starsCount {
                stars.text = String(starCount)
            }
            
            if let forksCount = dto.forksCount {
                forks.text = String(forksCount)
            }
            
            stylingRepositorieCellComponents()
        }
        
        func pullCell(dto: CellDTO) {
            commonStats(with: dto)
            
            if let date = dto.date {
                stars.text = String(date)
            }
            
            markRender(dto.description)
            stylingPullsCellComponents()
        }
        
        func styleCell() {
            outline.layer.cornerRadius = Layout.Cell.outlineCornerRadius
            outline.layer.borderWidth = Layout.Cell.outlineBorderWidth
            outline.layer.borderColor = Layout.Cell.outlineBorderColor
            authorPic.layer.cornerRadius = Layout.Cell.cornerRadius(for: authorPic)
        }
        
        func stylingRepositorieCellComponents() {
            mainIcon.image = UIImage(systemName: Strings.Sf.Symbols.repo)
            bottomIcon.image = UIImage(systemName: Strings.Sf.Symbols.star)
            forkIcon.isHidden = false
            forks.isHidden = false
        }
        
        func stylingPullsCellComponents() {
            mainIcon.image = UIImage(systemName: Strings.Sf.Symbols.pull)
            bottomIcon.image = UIImage(systemName: Strings.Sf.Symbols.date)
            
            forks.isHidden = true
            forkIcon.isHidden = true
        }
        
        func markRender(_ body: String) {
            let down = Down(markdownString: body)
            let style = "body { font: 100% sans-serif; color: dimgray; }"
            let atributedString = try? down.toAttributedString(stylesheet: style)
            bodyDescription.attributedText = atributedString
        }
        
        func commonStats(with dto: CellDTO) {
            authorName.text = dto.authorName
            authorPic.kf.setImage(with: URL(string: dto.authorPicUrl))
            title.text = dto.title
            styleCell()
        }
    }
