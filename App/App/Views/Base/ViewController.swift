import UIKit
import RxSwift
import RxCocoa

class ViewController<UI: View>: UIViewController {
    let disposeBag = DisposeBag()
    
    var ui: UI {
        view as! UI
    }
    
    override func loadView() {
        view = UI()
    }
}

