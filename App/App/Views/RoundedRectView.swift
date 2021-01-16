import UIKit

final class RoundedRectView: View {
    
    var scale = CGFloat(0.97)
    
    override func setupAppearance() {
        backgroundColor = .white
        layer.cornerRadius = Constants.UI.cornerRadius
    }
    
    func setSelected(_ selected: Bool, animated: Bool) {
        let transform: CGAffineTransform
        if selected {
            transform = CGAffineTransform(scaleX: scale, y: scale)
        } else {
            transform = .identity
        }
        
        if animated {
            UIView.animate(withDuration: 0.1) {
                self.transform = transform
            }
        } else {
            self.transform = transform
        }
    }
}
