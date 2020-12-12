import UIKit

final class TimesUI: View {
    let stackView = UIStackView()
    let tableView = UITableView()
    let messageContainer = UIView()
    let messageLabel = UILabel()
    
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
        tableView.backgroundColor = Asset.backgroundColor.color
        messageContainer.backgroundColor = Asset.backgroundColor.color
        
        let size = CGSize(width: 0, height: 6)
        let frame = CGRect(origin: .zero, size: size)
        tableView.tableFooterView = UIView(frame: frame)
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
    }
}
