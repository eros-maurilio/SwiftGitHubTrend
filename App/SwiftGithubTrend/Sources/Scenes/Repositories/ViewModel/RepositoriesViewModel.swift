import Foundation

typealias RepoSearchResult = Result<SearchResponse, NSError>

final class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    // MARK: - Public Atribute
    
    var isLoading = false
    
    // MARK: - Private Atrivutes
    
    private weak var delegate: LoadContentable?
    private var repositories = [Item]()
    private var currentPage: Int
    
    // MARK: - Life Cycle
    
    init(delegate: LoadContentable) {
        self.delegate = delegate
        self.currentPage = 0
    }
}

extension RepositoriesViewModel {
    
    func numberOfRows() -> Int {
        return repositories.count
    }
    
    func numberOfSections() -> Int {
        return TableSection.sectionCount()
    }
    
    func loadRepositories() {
        
        guard !DataLoader().isLoading else {
            return
        }
        
        isLoading = true
        
        DataLoader().request(.findRepositories(using: APIParametersType.Language.swift,
                                               sortedBy: APIParametersType.Sorting.stars,
                                               atPage: newPage())) { [weak self] (result: RepoSearchResult) in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(repoData):
                self.repositories.append(contentsOf: repoData.items)
                self.delegate?.didLoad()
                self.isLoading = false
                
            case let .failure(error):
                self.isLoading = false
                debugPrint(error)
            }
        }
    }
    
    func dtoForRows(indexPath: IndexPath) -> CellDTO {
        let item = repositories[indexPath.row]
        let title = item.repoName
        let subtitle = item.repoDescription
        let author = item.owner
        let stars = item.starsCount
        let forks = item.forksCount
        
        return CellDTO(title: title,
                       description: subtitle ?? Strings.Api.Response.Description.empty,
                       authorName: author.login,
                       authorPicUrl: author.avatarUrl,
                       starsCount: stars,
                       forksCount: forks)
    }
    
    func transporter(indexPath: IndexPath) -> String {
        let item = repositories[indexPath.row]
        
        return item.repoPath
    }
    
    func showRepositorie(_ repoPath: String) {
        delegate?.displayRepositorie(repoPath)
    }
}

private extension RepositoriesViewModel {
    func newPage() -> String {
        currentPage += 1
        
        return String(currentPage)
    }
}
