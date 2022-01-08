import UIKit

class LoadingCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!

}

    // MARK: - Public Methods

extension LoadingCell {

    func startLoadingAnimation() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }
}
