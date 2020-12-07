import UIKit
import MapKit

final class StopPointClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? MKClusterAnnotation else {
            return
        }
        let count = annotation.memberAnnotations.count
        image = drawImage(count: count)
        collisionMode = .circle
        displayPriority = .defaultHigh
        canShowCallout = false
    }
    
    private func drawImage(count: Int) -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        return UIGraphicsImageRenderer(size: size).image { (context) in
            let frame = CGRect(origin: .zero, size: size)
            
            UIColor.white.setFill()
            UIBezierPath(ovalIn: frame).fill()
            
            let margin = CGFloat(2)
            let innterOvalRect = frame.inset(by: UIEdgeInsets(all: margin))
            
            Asset.backgroundColor.color.setFill()
            UIBezierPath(ovalIn: innterOvalRect).fill()
            
            let text = String(count)
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .semibold)
            ]
            let textSize = text.size(withAttributes: attributes)
            let textRect = CGRect(
                x: size.width / 2 - textSize.width / 2,
                y: size.height / 2 - textSize.height / 2,
                width: textSize.width,
                height: textSize.height
            )
            text.draw(in: textRect, withAttributes: attributes)
        }
    }
}

