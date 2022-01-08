import UIKit

class LoadingCell: UITableViewCell {
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
}

extension LoadingCell {
    func startLoadingAnimation() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }
}
