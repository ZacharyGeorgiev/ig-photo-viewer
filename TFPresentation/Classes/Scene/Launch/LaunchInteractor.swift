//
//  LaunchInteractor.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import TFDomain
import Resolver

enum LaunchInteractorRequest {
    case didRefresh
}

final class LaunchInteractor {
    // MARK: Private properties
    @Injected private var workQueue: WorkQueue
    @Injected private var postsWorker: PostsWorker

    private var presenter: LaunchPresenter?
    
    // MARK: Internal methods
    func setup(with presenter: LaunchPresenter) {
        self.presenter = presenter
    }
    
    func handle(request: LaunchInteractorRequest) {
        workQueue.async {
            switch request {
            case .didRefresh:
                self.handleDidRefresh()
            }
        }
    }
}

// MARK: - Requests
extension LaunchInteractor {
    func handleInitialize() {
        presenter?.present(isLoading: true)
        Task {
            guard let posts = await getPosts() else { return }
            presenter?.presentInitialize(with: posts)
            presenter?.present(isLoading: false)
        }
    }
    
    func handleDidRefresh() {
        Task {
            guard let posts = await getPosts() else { return }
            presenter?.presentRefreshedPosts(posts)
        }
    }
}

private extension LaunchInteractor {
    func getPosts() async -> [IGPost]? {
        return try? await postsWorker.getPosts()
    }
}
