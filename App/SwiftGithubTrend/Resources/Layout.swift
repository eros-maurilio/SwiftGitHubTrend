import UIKit

enum Layout {
    
    enum Cell {
        static let outlineCornerRadius: CGFloat = 10
        static let outlineBorderWidth: CGFloat = 1
        static let outlineBorderColor: CGColor = UIColor.secondarySystemFill.cgColor
        static let estimatedRowHeight: CGFloat = 160
        
        static func cornerRadius(for pic: UIImageView) -> CGFloat {
            CGFloat(pic.frame.height / 2) }
        
    }
}
