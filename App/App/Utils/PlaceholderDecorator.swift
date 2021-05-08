import UIKit
import Domain
import RxSwift

struct PlaceholderDecorator<T: UIView>: Decorator {
    
    let style: Placeholder
    
    func apply(on object: T) -> AnyObserver<Bool> {
        let placeholder = PlaceholderView()
        placeholder.configure(with: style)
        object.add(subviews: placeholder)
        
        NSLayoutConstraint.activate([
            placeholder.centerYAnchor.constraint(equalTo: object.centerYAnchor),
            placeholder.leadingAnchor.constraint(equalTo: object.leadingAnchor, constant: Constants.UI.defaultSpacing).with(priority: .defaultHigh),
            placeholder.trailingAnchor.constraint(equalTo: object.trailingAnchor, constant: -Constants.UI.defaultSpacing).with(priority: .defaultHigh)
        ])
        
        return placeholder.rx.isHidden.mapObserver({ !$0 })
    }
}
