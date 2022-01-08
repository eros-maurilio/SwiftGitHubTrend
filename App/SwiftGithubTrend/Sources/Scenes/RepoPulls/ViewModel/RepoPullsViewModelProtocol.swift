import Foundation

protocol RepoPullsViewModelProtocol: AnyObject {
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func loadRepo(repoPath: String)
    func setup(_ repoPath: String)
    func dtoForRows(indexPath: IndexPath) -> CellDTO
}

protocol LoadViewDelegate: AnyObject {
    func didLoadContent()
}
