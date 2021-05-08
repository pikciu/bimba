import UIKit
import RxCells

protocol PlaceholderViewModelType {
    var image: UIImage { get }
    var text: String { get }
}

final class PlaceholderView: View, Configurable {
    let imageView = UIImageView()
    let label = UILabel()
    
    override func setupAutoLayout() {
        add(subviews: imageView, label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.UI.defaultSpacing),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.UI.defaultSpacing),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.UI.defaultSpacing),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func setupAppearance() {
        label.font = AppFont.titleFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Asset.secondaryColor.color
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Asset.secondaryColor.color
    }
    
    func configure(with model: PlaceholderViewModelType) {
        isHidden = false
        imageView.image = model.image.withRenderingMode(.alwaysTemplate)
        label.text = model.text
    }
}

enum Placeholder: PlaceholderViewModelType {
    case favorites
    case search
    case noLocationPermissions
    case noResults
    case error
    
    var image: UIImage {
        switch self {
        case .favorites:
            return Asset.starPlaceholder.image
        case .search:
            return Asset.searchPlaceholder.image
        case .noLocationPermissions:
            return Asset.errorPlaceholder.image
        case .noResults:
            return Asset.errorPlaceholder.image
        case .error:
            return Asset.errorPlaceholder.image
        }
    }
    
    var text: String {
        switch self {
        case .favorites:
            return L10n.favoritePlaceholder
        case .search:
            return L10n.searchPlaceholder
        case .noLocationPermissions:
            return L10n.noLocationPermissionsPlaceholder
        case .noResults:
            return L10n.searchNoResultPlaceholder
        case .error:
            return L10n.errorPlaceholder
        }
    }
}
