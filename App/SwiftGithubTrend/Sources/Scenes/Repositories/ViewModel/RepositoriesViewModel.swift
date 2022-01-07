import Foundation

typealias RepoSearchResult = Result<SearchResponse, NSError>

final class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    private weak var delegate: LoadContentable?
    private var repositories = [Item]()
    private var currentPage: Int
    
    init(delegate: LoadContentable) {
        self.delegate = delegate
        self.currentPage = 0
    }
    
    func numberOfRows() -> Int {
        repositories.count
    }
    
    func numberOfSections() -> Int {
        [repositories].count
    }
    
    func loadRepositories() {
        
        guard !DataLoader().isLoading else {
            return
        }
        
        DataLoader().request(.findRepositories(using: APIParametersType.Language.swift,
                                               sortedBy: APIParametersType.Sorting.stars,
                                               atPage: newPage())) { [weak self] (result: RepoSearchResult) in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(repoData):
                self.repositories.append(contentsOf: repoData.items)
                self.delegate?.didLoad()
                
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    func showRepositorie() {
        
    }
    
    func dtoForRows(indexPath: IndexPath) -> CellDTO {
        let item = repositories[indexPath.row]
        let title = item.repoName
        let subtitle = item.repoDescription
        let author = item.owner
        let stars = item.starsCount
        let forks = item.forksCount
        
        return CellDTO(repoName: title,
                       repoDescription: subtitle ?? "",
                       authorName: author.login,
                       starsCount: stars,
                       forksCount: forks)
    }
    
    func transporter() {
        
    }
}

extension RepositoriesViewModel {
    private func newPage() -> String {
        currentPage += 1
        
        return String(currentPage)
    }
}
