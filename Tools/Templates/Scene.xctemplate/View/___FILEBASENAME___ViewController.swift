//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

protocol ___VARIABLE_sceneName___DisplayLogic: AnyObject {
    
}

// MARK: ViewController
final class ___VARIABLE_sceneName___ViewController: UIViewController {
    
    // MARK: Internal properties
    
    // MARK: Private properties
    private let interactor: ___VARIABLE_sceneName___Interactor
    
    // MARK: Lifecycle
    required init(interactor: ___VARIABLE_sceneName___Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        interactor.handleInitialize()
    }
}

// MARK: ___VARIABLE_sceneName___DisplayLogic
extension ___VARIABLE_sceneName___ViewController: ___VARIABLE_sceneName___DisplayLogic {
    
}

// MARK: Private setup methods
private extension ___VARIABLE_sceneName___ViewController {
    
    func setup() {
        
    }
}
