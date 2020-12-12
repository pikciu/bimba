import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        localizeInterface()
        setupAutoLayout()
        setupActionHandlers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAppearance() {
        
    }
    
    func setupAutoLayout() {
        
    }
    
    func localizeInterface() {
        
    }
    
    func setupActionHandlers() {
        
    }
}
