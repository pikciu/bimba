import UIKit

extension UIImage {
    
    convenience init?(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(rect)
        guard
            let image = UIGraphicsGetImageFromCurrentImageContext(),
            let cgImage = image.cgImage
        else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    func with(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return nil
        }
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        context.setBlendMode(.normal)
        
        let rect = CGRect(origin: .zero, size: size)
        context.clip(to: rect, mask: cgImage)
        context.fill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
