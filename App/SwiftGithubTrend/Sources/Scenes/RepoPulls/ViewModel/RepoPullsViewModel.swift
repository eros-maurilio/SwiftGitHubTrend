import Foundation

typealias RepoPullsResult = Result<[RepoPullsResponse], NSError>

final class RepoPullsViewModel: RepoPullsViewModelProtocol {
    
    var isLoading = false
    private var repoResponse = [RepoPullsResponse]()
    private weak var delegate: LoadViewDelegate?
    
    init(delegate: LoadViewDelegate) {
        self.delegate = delegate
    }
    
    func numberOfRows() -> Int {
        repoResponse.count
    }
    
    func numberOfSections() -> Int {
        2
    }
    
    func setup(_ repoPath: String) {
        loadRepo(repoPath: repoPath)
    }
    
    func loadRepo(repoPath: String) {
        
        isLoading = true
        
        DataLoader().request(.watch(repo: repoPath, listedBy: Localizable.Repo.Item.listing)) { [weak self] (result: RepoPullsResult) in
            guard let self = self else { return }
            
            switch result {
            case let .success(repoData):
                DispatchQueue.main.async {
                    self.repoResponse = repoData
                    self.delegate?.didLoadContent()
                    self.isLoading = false
                }
                
            case let .failure(error):
                self.isLoading = false
                debugPrint(error)
            }
        }
    }
    
    func dtoForRows(indexPath: IndexPath) -> CellDTO {
        let pullItem = repoResponse[indexPath.row]
        let title = pullItem.title
        let body = pullItem.body
        let author = pullItem.head.repo.owner
        let date = pullItem.head.repo.createdAt
        
        return CellDTO(repoName: title ?? "",
                       repoDescription: body ?? "",
                       authorName: author.login,
                       authorPicUrl: author.avatarUrl,
                       date: date)
    }
}
