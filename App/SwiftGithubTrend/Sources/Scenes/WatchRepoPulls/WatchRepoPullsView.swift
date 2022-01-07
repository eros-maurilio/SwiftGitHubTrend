import UIKit
import Down

class WatchRepoPullsView: UIViewController {
    
    private lazy var viewModel: WatchRepoPullsViewModelProtocol = WatchRepoPullsViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setup(_ repo: (author: String, repo: String)) {
        viewModel.setup(repo)
    }
}

private extension WatchRepoPullsView {
    func setupView() {

    }
}

extension WatchRepoPullsView: LoadViewDelegate {
    func didLoadContent() {
        
        let repo = viewModel.repo.first
        let down = Down(markdownString: repo?.body ?? "")
        let style = "body { font: 120% sans-serif; color:\(traitCollection.userInterfaceStyle == .light ? "black" : "white"); }"
        let atributedString = try? down.toAttributedString(stylesheet: style)
//        bodyLabel.attributedText = atributedString
        
    }
}
