import UIKit
import RxSwift
import RxCocoa

class ViewController<UI: View>: UIViewController {
    let disposeBag = DisposeBag()
    
    var ui: UI {
        view as! UI
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UI()
    }
}

