import Foundation

protocol WatchRepoPullsViewModelProtocol: AnyObject {
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func loadRepo(repo: (author: String, repo: String))
    func setup(_ repo: (author: String, repo: String))
    func dtoForRows(indexPath: IndexPath) -> CellDTO
}

protocol LoadViewDelegate: AnyObject {
    func didLoadContent()
}
