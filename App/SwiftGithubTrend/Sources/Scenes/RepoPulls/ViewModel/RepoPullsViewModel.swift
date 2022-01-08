import Foundation

typealias RepoPullsResult = Result<[RepoPullsResponse], NSError>

final class RepoPullsViewModel: RepoPullsViewModelProtocol {
    // MARK: - Public Attributes
    
    var isLoading = false
    
    // MARK: - Private Attributes
    
    private var repoResponse = [RepoPullsResponse]()
    private weak var delegate: LoadViewDelegate?
    
    // MARK: - Life Cycle
    
    init(delegate: LoadViewDelegate) {
        self.delegate = delegate
    }
}

    // MARK: - Public Methods

extension RepoPullsViewModel {
    
    func numberOfRows() -> Int {
        return repoResponse.count
    }
    
    func numberOfSections() -> Int {
        return TableSection.sectionsCount()
    }
    
    func setup(_ repoPath: String) {
        loadRepo(repoPath: repoPath)
    }
    
    func loadRepo(repoPath: String) {
        
        isLoading = true
        
        DataLoader().request(.watch(repo: repoPath, listedBy: Strings.Query.Item.listing)) { [weak self] (result: RepoPullsResult) in
            guard let self = self else { return }
            
            switch result {
            case let .success(repoData):
                DispatchQueue.main.async {
                    self.repoResponse = repoData
                    
                    if !self.repoResponse.isEmpty {
                        self.delegate?.didLoadContent(success: true, error: nil)
                    } else {
                        self.delegate?.didLoadContent(success: false, error: "There is no pull requests to show")
                    }
                    
                    self.isLoading = false
                }
                
            case let .failure(error):
                self.isLoading = false
                self.delegate?.didLoadContent(success: false, error: error.userInfo.values.first as? String ?? "")
            }
        }
    }
    
    func dtoForRows(indexPath: IndexPath) -> CellDTO {
        let pullItem = repoResponse[indexPath.row]
        let title = pullItem.title
        let body = pullItem.body
        let author = pullItem.head.repo.owner
        let date = pullItem.head.repo.createdAt
        
        return CellDTO(title: title,
                       description: body ?? "",
                       authorName: author.login,
                       authorPicUrl: author.avatarUrl,
                       date: date)
    }
}
