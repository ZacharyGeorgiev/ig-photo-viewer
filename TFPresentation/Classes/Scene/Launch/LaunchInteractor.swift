//
//  LaunchInteractor.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import TFDomain
import Resolver

final class LaunchInteractor {
    // MARK: Private properties
    @Injected private var postsWorker: PostsWorker

    private var presenter: LaunchPresenter?
    
    // MARK: Internal methods
    func setup(with presenter: LaunchPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Requests
extension LaunchInteractor {
    func handleInitialize() {
        presenter?.present(isLoading: true)
        Task {
            guard let posts = try? await postsWorker.getPosts() else { return }
            presenter?.presentInitialize(with: posts)
            presenter?.present(isLoading: false)
        }
    }
}
