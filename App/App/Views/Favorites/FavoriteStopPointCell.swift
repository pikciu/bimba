import UIKit
import Domain

final class FavoriteStopPointCell: TableViewCell<StopPointDetails> {
    
    let rootView = RoundedRectView()
    let vehicleImages = VehicleTypeView()
    let nameLabel = UILabel()
    let headsingsLabel = UILabel()
    
    override func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        
        nameLabel.font = AppFont.titleFont
        headsingsLabel.font = AppFont.subtitleFont
        
        nameLabel.textColor = Asset.primaryColor.color
        headsingsLabel.textColor = Asset.secondaryColor.color
        
        nameLabel.numberOfLines = 0
        headsingsLabel.numberOfLines = 0
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: rootView)
        rootView.add(subviews: vehicleImages, nameLabel, headsingsLabel)
        
        let spacing = Constants.UI.defaultSpacing
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing / 2),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing / 2),
            
            nameLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant: Constants.UI.systemSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: spacing),
            
            headsingsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            headsingsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            headsingsLabel.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -Constants.UI.systemSpacing),
            
            vehicleImages.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -spacing),
            vehicleImages.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            vehicleImages.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: spacing)
        ])
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        rootView.setSelected(highlighted, animated: true)
    }
    
    override func configure(with model: StopPointDetails) {
        nameLabel.text = model.name
        headsingsLabel.text = model.headsings
        vehicleImages.configure(with: model.type)
    }
}

import Domain
import RxCells

final class VehicleTypeView: View, Configurable {
    let images = [UIImageView(), UIImageView()]
    
    override func setupAutoLayout() {
        add(subviews: images)
        
        let topBottomWidth = images.flatMap { (image) in
            [
                image.topAnchor.constraint(equalTo: topAnchor),
                image.bottomAnchor.constraint(equalTo: bottomAnchor),
                image.widthAnchor.constraint(equalToConstant: 20)
            ]
        }
        
        NSLayoutConstraint.activate(topBottomWidth)
        
        NSLayoutConstraint.activate([
            images[0].leadingAnchor.constraint(equalTo: leadingAnchor),
            images[1].leadingAnchor.constraint(equalTo: images[0].trailingAnchor, constant: 4),
            images[1].trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with model: [StopPointDetails.Route]) {
        images.forEach { (imageView) in
            imageView.image = nil
        }
        zip(model, images.reversed()).forEach { (type, imageView) in
            imageView.image = type.image
        }
    }
}

extension StopPointDetails.Route {
    var image: UIImage {
        switch self {
        case .bus:
            return Asset.bus.image
        case .tram:
            return Asset.tram.image
        }
    }
}
