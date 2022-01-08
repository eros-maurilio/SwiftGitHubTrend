import UIKit

enum CellFactory {
    
    enum CellType {
        case repositories, pulls
    }
    
    static func standard(_ tableView: UITableView, at indexPath: IndexPath, forACellDTO aCellDTO: CellDTO, cellType type: CellType) -> StandardViewCell {
        let cell = tableView.dequeCell(StandardViewCell.self, indexPath)
        cell.selectCellType(of: type, with: aCellDTO)
        return cell
    }
    
    static func loading(_ tableView: UITableView, at indexPath: IndexPath) -> LoadingCell {
        let cell = tableView.dequeCell(LoadingCell.self, indexPath)
        cell.startLoadingAnimation()
        return cell
    }
}
