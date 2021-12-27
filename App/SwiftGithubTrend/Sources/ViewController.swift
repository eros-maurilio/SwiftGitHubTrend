import UIKit

typealias RepoSearch = Result<Search, NSError>
typealias RepoWatch = Result<[Watch], NSError>

class ViewController: UIViewController {
    private var search = Search(items: [])
    private var repo: [Watch]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Navigation Bar Title"
        view.backgroundColor = .red
        
        let dataLoader = DataLoader()
        
        dataLoader.request(.findRepositories(using: APIParameters.Language.swift,
                                             sortedBy: APIParameters.Sorting.stars)) { [weak self] (result: RepoSearch) in
            
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
                
        dataLoader.request(.watch(repo: "vsouza", from: "awesome-ios", listedBy: "pulls")) { [weak self] (result: RepoWatch) in
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
