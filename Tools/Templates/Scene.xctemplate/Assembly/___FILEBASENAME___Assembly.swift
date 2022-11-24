//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Swinject
import SwinjectAutoregistration

public final class ___VARIABLE_sceneName___Assembly: Assembly {
    
    // MARK: Lifecycle
    public init() { }
    
    // MARK: Public methods
    public func assemble(container: Container) {
        container.autoregister(___VARIABLE_sceneName___ViewControllerFactory.self, initializer: ___VARIABLE_sceneName___ViewControllerFactory.init)
        container.autoregister(___VARIABLE_sceneName___Interactor.self, initializer: ___VARIABLE_sceneName___Interactor.init)
        container.autoregister(___VARIABLE_sceneName___Presenter.self, initializer: ___VARIABLE_sceneName___Presenter.init)
    }
}
