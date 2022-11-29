//
//  LaunchPresenter.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import Foundation
import TFDomain

final class LaunchPresenter {
    // MARK: Private properties
    private weak var displayLogic: LaunchViewController?
    private var router: LaunchRouter?
    
    func setup(with displayLogic: LaunchViewController?, router: LaunchRouter?) {
        self.displayLogic = displayLogic
        self.router = router
    }
}

// MARK: Present
extension LaunchPresenter {
    func presentInitialize(with images: [IGImage]) {
        let viewModel = setupViewModel(with: images)
        displayLogic?.update(with: viewModel)
    }
}

// MARK: Private helper methods
private extension LaunchPresenter {
    func setupViewModel(with images: [IGImage]) -> [IGImageCell.ViewModel] {
        return images.map {
            return .init(
                username: $0.username,
                imageUrl: $0.url,
                caption: $0.caption,
                timestamp: "5 hours ago"
            )
        }
    }
}
