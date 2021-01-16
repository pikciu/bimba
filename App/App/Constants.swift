import UIKit

enum Constants {
    enum UI {
        /// 12
        static let defaultSpacing = CGFloat(12)
        
        /// 8
        static let systemSpacing = CGFloat(8)
        
        /// 8
        static let cornerRadius = CGFloat(8)
        
        static let spacingViewSize = CGSize(width: 0, height: defaultSpacing / 2)
        static let spacingViewFrame = CGRect(origin: .zero, size: spacingViewSize)
        
    }
    
    static let noBreakChar = Character(Unicode.Scalar(UInt8(0xa0)))
    static let directionArrow = "➙"
}
