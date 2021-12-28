import Foundation

typealias RepoSearchResult = Result<SearchResponse, NSError>

final class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    private weak var delegate: LoadContentable?
    private var repositories: SearchResponse?
    
    init(delegate: LoadContentable) {
        self.delegate = delegate
    }
    
    func numberOfRows() -> Int {
        repositories?.items.count ?? 0
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
                
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    func showRepositorie() {
        
    }
    
    func dtoForRows(indexPath: IndexPath) -> CellDTO {
        return CellDTO(repoName: "", repoDescription: "")
    }
    
    func transporter() {
        
    }
}
