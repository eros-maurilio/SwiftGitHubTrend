import Foundation

protocol RepositoriesViewModelProtocol: AnyObject {
    var isLoading: Bool { get }
    
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func loadRepositories()
    func dtoForRows(indexPath: IndexPath) -> CellDTO
    func transporter(indexPath: IndexPath) -> (author: String, repo: String) // TODO: change model
    func showRepositorie(_ repo: (author: String, repo: String))
    
}

protocol LoadContentable: AnyObject {
    func didLoad()
    func displayRepositorie(_ repo: (author: String, repo: String))
}
