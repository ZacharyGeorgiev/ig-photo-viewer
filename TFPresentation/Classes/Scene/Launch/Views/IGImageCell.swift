//
//  IGImageCell.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import Nuke

class IGImageCell: UITableViewCell {
    // MARK: Public properties
    public static let identifier = "imageCell"
    
    // MARK: Private properties
    private lazy var stackView: UIStackView = makeStackView()
    private lazy var usernameLabel: UILabel = makeUsernameLabel()
    private lazy var postImageView: UIImageView = makePostImageView()
    private lazy var captionLabel: UILabel = makeCaptionLabel()
    private lazy var timestampLabel: UILabel = makeTimestampLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IGImageCell {
    func update(with viewModel: ViewModel) {
        let imageRequest = ImageRequest(url: viewModel.imageUrl)
        Nuke.loadImage(with: imageRequest, into: postImageView)
        
        usernameLabel.text = viewModel.username
        captionLabel.text = viewModel.caption
        timestampLabel.text = viewModel.timestamp
    }
}

// MARK: Private setup methods
private extension IGImageCell {
    func setup() {
        addSubview(stackView)
        
        postImageView.easy.layout(Height(0.45 * UIScreen.main.bounds.height))
        
        [usernameLabel,
         captionLabel,
         timestampLabel].forEach({ setLabelConstraints(for: $0) })
        
        stackView.easy.layout(
            Top(10),
            Bottom(10),
            Left(),
            Right()
        )
    }
}

// MARK: Factory
private extension IGImageCell {
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            makeContainerView(for: usernameLabel),
            postImageView,
            makeContainerView(for: captionLabel),
            makeContainerView(for: timestampLabel)
        ])
        stackView.spacing = 7
        stackView.axis = .vertical
        return stackView
    }
    
    func makeUsernameLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .regularBold
        return label
    }
    
    func makePostImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func makeCaptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .regular
        label.numberOfLines = 0
        return label
    }
    
    func makeTimestampLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = .subtext
        return label
    }
    
    func makeContainerView(for view: UIView) -> UIView {
        let containerView = UIView()
        containerView.addSubview(view)
        return containerView
    }
}

// MARK: Private helper methods
private extension IGImageCell {
    func setLabelConstraints(for label: UILabel) {
        label.easy.layout(
            Top(),
            Bottom(),
            Left(UIEdgeInsets.pageDefault.left),
            Right(UIEdgeInsets.pageDefault.right)
        )
    }
}

extension IGImageCell {
    struct ViewModel {
        let username: String
        let imageUrl: URL
        let caption: String
        let timestamp: String
    }
}
