//
//  ErrorView.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 04/12/2022.
//

import Foundation
import UIKit
import EasyPeasy

class ErrorView: UIView {
    // MARK: Private properties
    private lazy var imageView: UIImageView = makeImageView()
    private lazy var descriptionLabel: UILabel = makeDescriptionLabel()
    
    // MARK: Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
}

// MARK: Update methods
extension ErrorView {
    func update(with viewModel: ViewModel) {
        descriptionLabel.text = viewModel
    }
}

// MARK: Private setup methods
private extension ErrorView {
    func setup() {
        addSubviews(imageView, descriptionLabel)
        
        imageView.easy.layout(
            Top(),
            CenterX(),
            Width(0.25 * UIScreen.main.bounds.width),
            Height(0.25 * UIScreen.main.bounds.width)
        )
        descriptionLabel.easy.layout(
            Top(15).to(imageView, .bottom),
            Left(20),
            Right(20),
            Bottom()
        )
    }
}

// MARK: Factory
private extension ErrorView {
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "error")
        imageView.tintColor = .darkGray
        return imageView
    }
    
    func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = .heading
        label.numberOfLines = 0
        label.text = "Something went wrong"
        return label
    }
}

extension ErrorView {
    typealias ViewModel = String
}
