import UIKit
import Domain
import RxCocoa

final class MessageView: View {
    let label = UILabel()
    
    private(set) lazy var leadingConstraint = label.leadingAnchor.constraint(equalTo: leadingAnchor)
    
    override func setupAppearance() {
        backgroundColor = Asset.backgroundColor.color
        label.font = AppFont.titleFont
        label.textColor = Asset.secondaryColor.color
    }
    
    override func setupAutoLayout() {
        let margin = Constants.UI.defaultSpacing
        
        add(subviews: label)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            label.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin)
        ])
    }
    
    func animate(text: String) {
        label.text = text
        label.sizeToFit()
        
        let space = frame.width - 2 * Constants.UI.defaultSpacing
        let labelWidth = label.frame.width
        
        if labelWidth < space {
            leadingConstraint.constant = Constants.UI.defaultSpacing
        } else {
            leadingConstraint.constant = frame.width
            layoutIfNeeded()
            leadingConstraint.constant = -labelWidth
            let duration = labelWidth * 0.007
            
            UIView.animate(
                withDuration: TimeInterval(ceil(duration)),
                delay: 0,
                options: [.repeat, .curveLinear]
            ) {
                self.layoutIfNeeded()
            } completion: { _ in
                self.leadingConstraint.constant = 0
            }
        }
    }
}

struct MessageHeaderDecorator: Decorator {
    
    func apply(on object: UITableView) -> Binder<String?> {
        let messageView = MessageView()
        messageView.frame.size.height = 45
        
        return Binder(object) { (tableView, message) in
            if let message = message {
                tableView.tableHeaderView = messageView
                messageView.animate(text: message)
            } else {
                tableView.tableHeaderView = UIView(frame: Constants.UI.spacingViewFrame)
            }
        }
    }
}

