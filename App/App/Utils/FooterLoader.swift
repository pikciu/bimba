import UIKit
import RxSwift
import RxCocoa
import Domain

struct FooterLoader: Decorator {
    
    func apply(on object: UITableView) -> Binder<Bool> {
        let acitivtyIndicator = loaderView(for: object)
        let footerView = footer(with: acitivtyIndicator)
        
        return Binder(acitivtyIndicator) { [weak object] (acitivtyIndicator, isBusy) in
            if isBusy {
                object?.tableFooterView = footerView
                acitivtyIndicator.startAnimating()
            } else {
                object?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Constants.UI.systemSpacing / 2))
                acitivtyIndicator.stopAnimating()
            }
        }
    }
    
    private func footer(with subview: UIView) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        view.add(subviews: subview)
        
        subview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        subview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }
    
    private func loaderView(for tableView: UITableView) -> UIActivityIndicatorView {
        if let footer = tableView.tableFooterView {
            if let acitivtyIndicator = footer as? UIActivityIndicatorView {
                return acitivtyIndicator
            }
            debugPrint("WARNING: overriding table view footer")
            debugPrint(footer)
        }
        let acitivtyIndicator = create()
        acitivtyIndicator.color = .white
        acitivtyIndicator.hidesWhenStopped = true
        return acitivtyIndicator
    }
    
    private func create() -> UIActivityIndicatorView {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .large)
        } else {
            return UIActivityIndicatorView(style: .whiteLarge)
        }
    }
}
