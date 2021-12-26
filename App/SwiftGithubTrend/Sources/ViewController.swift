import UIKit

class ViewController: UIViewController {
    private var search = Search(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Navigation Bar Title"
        view.backgroundColor = .red
        
        var dataLoader = DataLoader()
        
        dataLoader.request(.findRepositories(using: APIParameters.Language.swift,
                                             sortedBy: APIParameters.Sorting.stars)) { [weak self] (result: Result<Search, NSError>) in
            
            switch result {
                
            case let .success(searchData):
                DispatchQueue.main.async {
                    self?.search = searchData
                    print(self?.search)
                }
                
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
