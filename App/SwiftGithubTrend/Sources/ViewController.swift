import UIKit

typealias RepoSearchResult = Result<SearchResponse, NSError>
typealias RepoWatchResult = Result<[WatchResponse], NSError>

class ViewController: UIViewController {
    private var search = SearchResponse(items: [])
    private var repo: [WatchResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Navigation Bar Title"
        view.backgroundColor = .red
        
        let dataLoader = DataLoader()
        
        dataLoader.request(.findRepositories(using: APIParametersType.Language.swift,
                                             sortedBy: APIParametersType.Sorting.stars)) { [weak self] (result: RepoSearchResult) in
            
            guard let self = self else { return }
            
            switch result {
                
            case let .success(searchData):
                DispatchQueue.main.async {
                    self.search = searchData
                    print(self.search)
                }
                
            case let .failure(error):
                debugPrint(error)
            }
        }
                
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
