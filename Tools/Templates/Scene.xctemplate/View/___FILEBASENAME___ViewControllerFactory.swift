//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Swinject

// MARK: Factory
struct ___VARIABLE_sceneName___ViewControllerFactory {
    
    let interactorProvider: Provider<___VARIABLE_sceneName___Interactor>
    let presenterProvider: Provider<___VARIABLE_sceneName___Presenter>
    
    func make(with router: ___VARIABLE_sceneName___RouterDelegate) -> ___VARIABLE_sceneName___ViewController {
        let interactor = interactorProvider.instance
        let presenter = presenterProvider.instance
        let viewController = ___VARIABLE_sceneName___ViewController(interactor: interactor)
        
        interactor.setup(with: presenter)
        presenter.setup(with: viewController, router: router)
        
        return viewController
    }
}
