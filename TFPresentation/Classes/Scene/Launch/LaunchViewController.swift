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
    private var images: [IGImageCell.ViewModel] {
        didSet {
            imagesTableView.reloadData()
        }
    }
    
    private lazy var headerView: IGHeaderView = makeHeaderView()
    private lazy var imagesTableView: UITableView = makeImagesTableView()
    
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
    func update(with viewModel: ViewModel) {
        syncSafe {
            self.images = viewModel
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IGImageCell.identifier, for: indexPath) as? IGImageCell else {
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
        view.addSubview(headerView)
        view.addSubview(imagesTableView)
        
        headerView.easy.layout(
            Top(),
            Left(),
            Right()
        )
        imagesTableView.easy.layout(
            Top().to(headerView),
            Left(),
            Right(),
            Bottom()
        )
    }
}

// MARK: Factory
private extension LaunchViewController {
    func makeHeaderView() -> IGHeaderView {
        let headerView = IGHeaderView()
        return headerView
    }
    
    func makeImagesTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(IGImageCell.self, forCellReuseIdentifier: IGImageCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }
}

// MARK: Model
extension LaunchViewController {
    typealias ViewModel = [IGImageCell.ViewModel]
}
