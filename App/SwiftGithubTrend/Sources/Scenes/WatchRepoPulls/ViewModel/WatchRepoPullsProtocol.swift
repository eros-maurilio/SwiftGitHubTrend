import Foundation

protocol WatchRepoPullsViewModelProtocol: AnyObject {
    var repo: [WatchResponse] { get }
    
    func setup(_ repo: (author: String, repo: String))
    func loadRepo(repo: (author: String, repo: String))
}

protocol LoadViewDelegate: AnyObject {
    func didLoadContent()
}
