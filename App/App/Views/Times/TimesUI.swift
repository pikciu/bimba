import UIKit

final class TimesUI: View {
    let stackView = UIStackView()
    let tableView = UITableView()
    let messageContainer = UIView()
    let messageLabel = UILabel()
    let favoriteButton = UIBarButtonItem()
    
    private(set) lazy var labelLeadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor)
    
    override func setupAutoLayout() {
        add(subviews: stackView)
        messageContainer.add(subviews: messageLabel)
        
        let messageMargin = CGFloat(8)
        
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(messageContainer)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: messageContainer.topAnchor, constant: messageMargin),
            messageLabel.bottomAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: -messageMargin),
            labelLeadingConstraint,
        ])
    }
    
    override func setupAppearance() {
        messageContainer.backgroundColor = Asset.backgroundColor.color
        
        tableView.apply(DefaultTableViewStyle())
        tableView.allowsSelection = false
    }
}

import Domain

struct DefaultTableViewStyle: Decorator {
    
    func apply(on object: UITableView) {
        object.backgroundColor = Asset.backgroundColor.color
        let size = CGSize(width: 0, height: Constants.UI.defaultSpacing / 2)
        let frame = CGRect(origin: .zero, size: size)
        object.tableFooterView = UIView(frame: frame)
        object.tableHeaderView = UIView(frame: frame)
        object.separatorStyle = .none
    }
}
