import UIKit


typealias RepoWatchResult = Result<[WatchResponse], NSError>

class ViewController: UIViewController {
    private var repo: [WatchResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataLoader = DataLoader()
                
        dataLoader.request(.watch(repo: "vsouza", from: "awesome-ios", listedBy: "pulls")) { [weak self] (result: RepoWatchResult) in
            guard let self = self else { return }
            
            
            switch result {
                
            case let .success(repoData):
                DispatchQueue.main.async {
                    self.repo = repoData
                    
                    if let repo = self.repo {
                        debugPrint(repo)
                        debugPrint("###################################################")
                    }
                }
            
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
