import Foundation

protocol RepoPullsViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func loadRepo(repoPath: String)
    func setup(_ repoPath: String)
    func dtoForRows(indexPath: IndexPath) -> CellDTO
}

protocol LoadViewDelegate: AnyObject {
    func didLoadContent()
}
