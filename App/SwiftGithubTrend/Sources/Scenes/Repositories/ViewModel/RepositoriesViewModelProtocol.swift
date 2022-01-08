import Foundation

protocol RepositoriesViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func loadRepositories()
    func dtoForRows(indexPath: IndexPath) -> CellDTO
    func transporter(indexPath: IndexPath) -> String
    func showRepositorie(_ repoPath: String)
    
}

protocol LoadContentable: AnyObject {
    func didLoad()
    func displayRepositorie(_ repoPath: String)
}
