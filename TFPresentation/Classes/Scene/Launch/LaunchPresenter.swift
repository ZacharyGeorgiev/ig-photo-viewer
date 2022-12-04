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
    func presentInitialize(with posts: [IGPost]) {
        let viewModel = setupViewModel(with: posts)
        displayLogic?.update(with: viewModel)
    }
}

// MARK: Private helper methods
private extension LaunchPresenter {
    func setupViewModel(with posts: [IGPost]) -> [IGPostCell.ViewModel] {
        return posts.compactMap {
            guard let mediaUrl = $0.mediaUrl else { return nil }
            return .init(
                username: $0.username,
                mediaUrl: mediaUrl,
                type: $0.type,
                caption: $0.caption,
                timestamp: "5 hours ago"
            )
        }
    }
}
