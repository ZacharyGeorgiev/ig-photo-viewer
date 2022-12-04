//
//  FeedViewController.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import UIKit
import EasyPeasy
import TFExtensions

// MARK: Factory
extension FeedViewController {
    convenience init(with router: FeedRouter) {
        let interactor = FeedInteractor()
        let presenter = FeedPresenter()
        self.init(interactor: interactor)
        
        interactor.setup(with: presenter)
        presenter.setup(with: self, router: router)
    }
}

// MARK: ViewController
public final class FeedViewController: UIViewController {
    // MARK: Internal properties
    
    // MARK: Private properties
    private let interactor: FeedInteractor
    private var posts: [IGPostCell.ViewModel] {
        didSet {
            postsTableView.reloadData()
        }
    }
    
    private lazy var contentView: UIView = makeContentView()
    private lazy var errorView: ErrorView = makeErrorView()
    private lazy var loadingIndicator: UIActivityIndicatorView = makeLoadingIndicator()
    private lazy var headerView: IGHeaderView = makeHeaderView()
    private lazy var postsTableView: UITableView = makePostsTableView()
    private lazy var refreshControl: UIRefreshControl = makeRefreshControl()
    
    // MARK: Lifecycle
    required init(interactor: FeedInteractor) {
        self.interactor = interactor
        self.posts = []
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        setup()
        interactor.handleInitialize()
    }
}

// MARK: Display logic
extension FeedViewController {
    func display(isLoading: Bool) {
        syncSafe {
            if isLoading {
                showLoadingIndicator()
            } else {
                showTableView()
            }
        }
    }
    
    func update(with viewModel: ViewModel) {
        syncSafe {
            self.posts = viewModel
        }
    }
    
    func display(isRefreshing: Bool) {
        syncSafe {
            if isRefreshing {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
    
    func display(errorViewModel: ErrorView.ViewModel) {
        syncSafe {
            errorView.update(with: errorViewModel)
            showView(errorView)
            hideView(loadingIndicator)
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IGPostCell.identifier, for: indexPath) as? IGPostCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.update(with: post)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: Private setup methods
private extension FeedViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubviews(
            headerView,
            contentView
        )
        
        errorView.easy.layout(
            Left(50),
            Right(50),
            CenterY()
        )
        loadingIndicator.easy.layout(Center())
        headerView.easy.layout(
            Top(),
            Left(),
            Right()
        )
        contentView.easy.layout(
            Top().to(headerView),
            Left(),
            Right(),
            Bottom()
        )
        postsTableView.easy.layout(Edges())
    }
}

// MARK: Factory
private extension FeedViewController {
    func makeContentView() -> UIView {
        let view = UIView()
        view.addSubviews(
            loadingIndicator,
            errorView,
            postsTableView
        )
        return view
    }
    
    func makeErrorView() -> ErrorView {
        let errorView = ErrorView()
        errorView.isHidden = true
        return errorView
    }
    
    func makeLoadingIndicator() -> UIActivityIndicatorView {
        let loadingIndicator = UIActivityIndicatorView()
        return loadingIndicator
    }
    
    func makeHeaderView() -> IGHeaderView {
        let headerView = IGHeaderView()
        return headerView
    }
    
    func makePostsTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(IGPostCell.self, forCellReuseIdentifier: IGPostCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.addSubview(refreshControl)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
    
    func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        return refreshControl
    }
}

// MARK: Model
extension FeedViewController {
    typealias ViewModel = [IGPostCell.ViewModel]
}

// MARK: Objc methods
@objc private extension FeedViewController {
    func didRefresh() {
        interactor.handle(request: .didRefresh)
    }
}

// MARK: Private helper methods
private extension FeedViewController {
    func showTableView() {
        showView(postsTableView)
        hideView(loadingIndicator)
        loadingIndicator.stopAnimating()
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        showView(loadingIndicator)
        hideView(postsTableView)
    }
    
    func showView(_ view: UIView) {
        view.alpha = 0
        view.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            view.alpha = 1
        }
    }
    
    func hideView(_ view: UIView) {
        UIView.animate(withDuration: 0.3) {
            view.alpha = 0
        } completion: { _ in
            view.isHidden = true
        }
    }
}
