import UIKit
import Domain

final class FavoriteStopPointCell: TableViewCell<StopPointDetails> {
    
    let rootView = UIView()
    let vehicleImages = VehicleTypeView()
    let nameLabel = UILabel()
    let headsingsLabel = UILabel()
    
    override func setupAppearance() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        rootView.backgroundColor = .white
        rootView.layer.cornerRadius = Constants.UI.cornerRadius
        
        nameLabel.font = AppFont.titleFont
        headsingsLabel.font = AppFont.subtitleFont
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
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            nameLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: spacing),
            nameLabel.bottomAnchor.constraint(equalTo: rootView.centerYAnchor),
            
            headsingsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            headsingsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            headsingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            
            vehicleImages.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -spacing),
            vehicleImages.centerYAnchor.constraint(equalTo: rootView.centerYAnchor)
        ])
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            rootView.backgroundColor = .lightGray
        } else {
            rootView.backgroundColor = .white
        }
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
        
        let topBottom = images.flatMap { (image) in
            [
                image.topAnchor.constraint(equalTo: topAnchor),
                image.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        }
        
        NSLayoutConstraint.activate(topBottom)
        
        NSLayoutConstraint.activate([
            images[0].leadingAnchor.constraint(equalTo: leadingAnchor),
            images[1].leadingAnchor.constraint(equalTo: images[0].trailingAnchor, constant: 4),
            images[1].trailingAnchor.constraint(equalTo: trailingAnchor),
            images[0].widthAnchor.constraint(equalTo: images[1].widthAnchor)
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
