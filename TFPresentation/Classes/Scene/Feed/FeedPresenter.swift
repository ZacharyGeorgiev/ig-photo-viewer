//
//  FeedPresenter.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import Foundation
import TFDomain

final class FeedPresenter {
    // MARK: Private properties
    private weak var displayLogic: FeedViewController?
    private var router: FeedRouter?
    
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM YYYY"
    }
    
    func setup(with displayLogic: FeedViewController?, router: FeedRouter?) {
        self.displayLogic = displayLogic
        self.router = router
    }
}

// MARK: Present
extension FeedPresenter {
    func present(isLoading: Bool) {
        displayLogic?.display(isLoading: isLoading)
    }
    
    func presentInitialize(with posts: [IGPost]) {
        let viewModel = setupViewModel(with: posts)
        displayLogic?.update(with: viewModel)
    }
    
    func presentRefreshedPosts(_ posts: [IGPost]) {
        presentInitialize(with: posts)
        displayLogic?.display(isRefreshing: false)
    }
    
    func present(error: Error) {
        displayLogic?.display(errorViewModel: getErrorDescription(for: error))
    }
}

// MARK: Private helper methods
private extension FeedPresenter {
    func setupViewModel(with posts: [IGPost]) -> [IGPostCell.ViewModel] {
        return posts.compactMap {
            guard let mediaUrl = $0.mediaUrl else { return nil }
            return .init(
                username: $0.username,
                mediaUrl: mediaUrl,
                type: $0.type,
                caption: $0.caption,
                timestamp: getTimestampString(from: $0.timestamp)
            )
        }
    }
}

private extension FeedPresenter {
    func getTimestampString(from date: Date) -> String {
        let monthsPassedFromDate = Date().months(from: date)
        guard monthsPassedFromDate < 12 else {
            return dateFormatter.string(from: date)
        }
        return date.relativeTimeString()
    }
    
    func getErrorDescription(for error: Error) -> String {
        let generalErrorMessage = "Something went wrong"
        guard let error = error as? ZGError else {
            return generalErrorMessage
        }
        switch error.type {
        case .decoding:
            return "Failed to decode response"
        case .sessionExpired:
            return "Access token expired"
        case .accessTokenMissing:
            return "Please provide an IG access token"
        default:
            return generalErrorMessage
        }
    }
}
