import Foundation

typealias RepoSearchResult = Result<SearchResponse, NSError>

final class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    private weak var delegate: LoadContentable?
    private var repositories = SearchResponse(items: [])
    
    init(delegate: LoadContentable) {
        self.delegate = delegate
    }
    
    func numberOfRows() -> Int {
        repositories.items.count
    }
    
    func numberOfSections() -> Int {
        [repositories].count
    }
    
    func loadRepositories() {
        DataLoader().request(.findRepositories(using: APIParametersType.Language.swift,
                                               sortedBy: APIParametersType.Sorting.stars)) { [weak self] (result: RepoSearchResult) in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(repoData):
                self.repositories = repoData
                self.delegate?.didLoad()
                
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    func showRepositorie() {
        
    }
    
    func dtoForRows(indexPath: IndexPath) -> CellDTO {
        let item = repositories.items[indexPath.row]
        let title = item.repoName
        let subtitle = item.repoDescription
        
        return CellDTO(repoName: title, repoDescription: subtitle ?? "")
        
    }
    
    func transporter() {
        
    }
}
