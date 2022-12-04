//
//  LaunchViewController.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import UIKit
import EasyPeasy
import TFExtensions

// MARK: Factory
extension LaunchViewController {
    convenience init(with router: LaunchRouter) {
        let interactor = LaunchInteractor()
        let presenter = LaunchPresenter()
        self.init(interactor: interactor)
        
        interactor.setup(with: presenter)
        presenter.setup(with: self, router: router)
    }
}

// MARK: ViewController
public final class LaunchViewController: UIViewController {
    // MARK: Internal properties
    
    // MARK: Private properties
    private let interactor: LaunchInteractor
    private var images: [IGPostCell.ViewModel] {
        didSet {
            postsTableView.reloadData()
        }
    }
    
    private lazy var loadingIndicator: UIActivityIndicatorView = makeLoadingIndicator()
    private lazy var headerView: IGHeaderView = makeHeaderView()
    private lazy var postsTableView: UITableView = makePostsTableView()
    private lazy var refreshControl: UIRefreshControl = makeRefreshControl()
    
    // MARK: Lifecycle
    required init(interactor: LaunchInteractor) {
        self.interactor = interactor
        self.images = []
        
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
extension LaunchViewController {
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
            self.images = viewModel
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
}

extension LaunchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension LaunchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IGPostCell.identifier, for: indexPath) as? IGPostCell else {
            return UITableViewCell()
        }
        let image = images[indexPath.row]
        cell.update(with: image)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: Private setup methods
private extension LaunchViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubviews(
            loadingIndicator,
            headerView,
            postsTableView
        )
        
        loadingIndicator.easy.layout(Center())
        headerView.easy.layout(
            Top(),
            Left(),
            Right()
        )
        postsTableView.easy.layout(
            Top().to(headerView),
            Left(),
            Right(),
            Bottom()
        )
    }
}

// MARK: Factory
private extension LaunchViewController {
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
        return tableView
    }
    
    func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        return refreshControl
    }
}

// MARK: Model
extension LaunchViewController {
    typealias ViewModel = [IGPostCell.ViewModel]
}

// MARK: Objc methods
@objc private extension LaunchViewController {
    func didRefresh() {
        interactor.handle(request: .didRefresh)
    }
}

// MARK: Private helper methods
private extension LaunchViewController {
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
