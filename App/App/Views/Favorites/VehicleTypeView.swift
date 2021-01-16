import UIKit
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

