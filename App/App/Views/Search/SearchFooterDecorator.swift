import UIKit
import Domain
import RxSwift
import RxCocoa

struct SearchFooterDecorator: Decorator {
    
    func apply(on object: UITableView) -> Binder<SearchPresenter.State> {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: object.bounds.height))
        let placeholderView = PlaceholderView()
        
        let activityIndicator = createActivityIndicator()
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        
        container.add(subviews: placeholderView, activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            placeholderView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.UI.defaultSpacing).with(priority: .defaultHigh),
            placeholderView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.UI.defaultSpacing).with(priority: .defaultHigh),
            placeholderView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        return Binder(object) { (tableView, state) in
            switch state {
            case .loading:
                tableView.backgroundView = container
                activityIndicator.startAnimating()
                placeholderView.isHidden = true
            case .empty:
                tableView.backgroundView = container
                activityIndicator.stopAnimating()
                placeholderView.configure(with: Placeholder.search)
            case .hasNoResults:
                tableView.backgroundView = container
                activityIndicator.stopAnimating()
                placeholderView.configure(with: Placeholder.noResults)
            case .hasResults:
                tableView.backgroundView = nil
            }
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .large)
        } else {
            return UIActivityIndicatorView(style: .whiteLarge)
        }
    }
}
