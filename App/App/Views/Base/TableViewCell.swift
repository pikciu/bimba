import UIKit
import Reusable
import RxCells

class TableViewCell<T>: UITableViewCell, Reusable, Configurable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        localizeInterface()
        setupAppearance()
        setupAutoLayout()
        setupActionHandlers()
    }
    
    func localizeInterface() {
        
    }
    
    func setupAppearance() {
        
    }
    
    func setupAutoLayout() {
        
    }
    
    func setupActionHandlers() {
        
    }
    
    func configure(with model: T) {
        
    }
}
