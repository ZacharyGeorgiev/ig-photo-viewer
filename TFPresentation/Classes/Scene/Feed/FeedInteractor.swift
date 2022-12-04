//
//  FeedInteractor.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import TFDomain
import Resolver

enum FeedInteractorRequest {
    case didRefresh
}

final class FeedInteractor {
    // MARK: Private properties
    @Injected private var workQueue: WorkQueue
    @Injected private var postsWorker: PostsWorker

    private var presenter: FeedPresenter?
    
    // MARK: Internal methods
    func setup(with presenter: FeedPresenter) {
        self.presenter = presenter
    }
    
    func handle(request: FeedInteractorRequest) {
        workQueue.async {
            switch request {
            case .didRefresh:
                self.handleDidRefresh()
            }
        }
    }
}

// MARK: - Requests
extension FeedInteractor {
    func handleInitialize() {
        presenter?.present(isLoading: true)
        Task {
            do {
                let posts = try await getPosts()
                presenter?.presentInitialize(with: posts)
                presenter?.present(isLoading: false)
            } catch {
                presenter?.present(error: error)
            }
        }
    }
    
    func handleDidRefresh() {
        Task {
            guard let posts = try? await getPosts() else { return }
            presenter?.presentRefreshedPosts(posts)
        }
    }
}

private extension FeedInteractor {
    func getPosts() async throws -> [IGPost] {
        return try await postsWorker.getPosts()
    }
}
