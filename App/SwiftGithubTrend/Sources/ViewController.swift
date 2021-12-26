import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Navigation Bar Title"
        view.backgroundColor = .red
        
        var dataLoader = DataLoader()
        
        dataLoader.request(.findRepositories(using: APIParameters.Language.swift,
                                             sortedBy: APIParameters.Sorting.stars)) { [weak self] (result: Result<[String], NSError>) in
            
        }
    }
}
