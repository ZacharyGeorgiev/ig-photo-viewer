//
//  LaunchViewController.swift
//  TFApp
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import UIKit
import EasyPeasy

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
    
    private lazy var headerView: IGHeaderView = makeHeaderView()
    
    // MARK: Lifecycle
    required init(interactor: LaunchInteractor) {
        self.interactor = interactor
        
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
    
}

// MARK: Private setup methods
private extension LaunchViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        
        headerView.easy.layout(
            Top(),
            Left(),
            Right()
        )
    }
}

// MARK: Factory
private extension LaunchViewController {
    func makeHeaderView() -> IGHeaderView {
        let headerView = IGHeaderView()
        return headerView
    }
}
