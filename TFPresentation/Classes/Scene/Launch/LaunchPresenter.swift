//
//  LaunchPresenter.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import Foundation

final class LaunchPresenter {
    // MARK: Private properties
    private weak var displayLogic: LaunchViewController?
    private var router: LaunchRouter?
    
    func setup(with displayLogic: LaunchViewController?, router: LaunchRouter?) {
        self.displayLogic = displayLogic
        self.router = router
    }
}

// MARK: - Responses
extension LaunchPresenter {
    
}
