//
//  LaunchInteractor.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import TFDomain

final class LaunchInteractor {
    // MARK: Private properties
    private var presenter: LaunchPresenter?
    
    // MARK: Lifecycle
    init() { }
    
    // MARK: Internal methods
    func setup(with presenter: LaunchPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Requests
extension LaunchInteractor {
    func handleInitialize() {
        
    }
}
