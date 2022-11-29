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
    @Injected private var imagesWorker: ImagesWorker

    private var presenter: LaunchPresenter?
    
    // MARK: Internal methods
    func setup(with presenter: LaunchPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Requests
extension LaunchInteractor {
    func handleInitialize() {
        Task {
            let images = try? await imagesWorker.getImages()
            guard let images = images else { return }
            presenter?.presentInitialize(with: images)
        }
    }
}

private extension LaunchInteractor {
    func fetchImages() async {
//        print("fetching images")
//        let images = try? await imagesWorker.getImages()
//        print("images \(images)")
    }
}
