import Foundation

typealias RepoWatchResult = Result<[WatchResponse], NSError>

final class WatchRepoPullsViewModel: WatchRepoPullsViewModelProtocol {
    private var repoResponse: [WatchResponse]?
    private var repositorie: (author: String, repo: String)?
    private weak var delegate: LoadViewDelegate?
    
    init(delegate: LoadViewDelegate) {
        self.delegate = delegate
    }
    
    var repo: [WatchResponse] {
        repoResponse ?? [WatchResponse(title: "", head: Head(repo: Repo(owner: Owner(login: "", avatarUrl: ""), createdAt: "")), body: "")]
    }
    
    func setup(_ repo: (author: String, repo: String)) {
        self.repositorie = repo
        loadRepo(repo: repo)
    }
    
    func loadRepo(repo: (author: String, repo: String)) {
        DataLoader().request(.watch(repo: repo.author, from: repo.repo, listedBy: "pulls")) { [weak self] (result: RepoWatchResult) in
            guard let self = self else { return }
            
            switch result {
                
            case let .success(repoData):
                DispatchQueue.main.async {
                    self.repoResponse = repoData
                    self.delegate?.didLoadContent()
                    print(self.repoResponse)
                    
                }
            
            case let .failure(error):
                debugPrint(error)
            }
        }

    }
}
