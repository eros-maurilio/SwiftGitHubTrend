import Foundation

typealias RepoWatchResult = Result<[WatchResponse], NSError>

final class RepoPullsViewModel: RepoPullsViewModelProtocol {
    
    private var repoResponse = [WatchResponse]()
    private weak var delegate: LoadViewDelegate?
    
    init(delegate: LoadViewDelegate) {
        self.delegate = delegate
    }
    
    func numberOfRows() -> Int {
        repoResponse.count
    }
    
    func numberOfSections() -> Int {
        [repoResponse].count
    }
    
    func setup(_ repoPath: String) {
        loadRepo(repoPath: repoPath)
    }
    
    func loadRepo(repoPath: String) {
        DataLoader().request(.watch(repo: repoPath, listedBy: Localizable.Repo.Item.listing)) { [weak self] (result: RepoWatchResult) in
            guard let self = self else { return }
            
            switch result {
            case let .success(repoData):
                DispatchQueue.main.async {
                    self.repoResponse = repoData
                    self.delegate?.didLoadContent()
                }
                
            case let .failure(error):
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
