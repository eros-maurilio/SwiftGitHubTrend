import Foundation

protocol RepositoriesViewModelProtocol: AnyObject {
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func loadRepositories()
    func showRepositorie()
    func dtoForRows(indexPath: IndexPath) -> CellDTO
    func transporter() // TODO: Need to change in the future
    
}

protocol LoadContentable: AnyObject {
    func didLoad()
    func displayRepositorie(_ repo: String)
}
