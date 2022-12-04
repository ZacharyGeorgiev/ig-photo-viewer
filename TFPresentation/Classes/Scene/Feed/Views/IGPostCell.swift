//
//  IGPostCell.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 28/11/2022.
//

import Foundation
import UIKit
import EasyPeasy
import Nuke
import TFDomain

class IGPostCell: UITableViewCell {
    // MARK: Public properties
    public static let identifier = "postCell"
    
    // MARK: Private properties
    private lazy var stackView: UIStackView = makeStackView()
    private lazy var mediaStackView: UIStackView = makeMediaStackView()
    private lazy var usernameLabel: UILabel = makeUsernameLabel()
    private lazy var mediaScrollView: UIScrollView = makeMediaScrollView()
    private lazy var captionLabel: UILabel = makeCaptionLabel()
    private lazy var timestampLabel: UILabel = makeTimestampLabel()
    private lazy var pageControl: UIPageControl = makePageControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IGPostCell {
    func update(with viewModel: ViewModel) {
        mediaStackView.removeAllArrangedSubviews()
        let mediaUrls = viewModel.type.mediaUrls
        mediaUrls.forEach { mediaUrl in
            let imageView = makeImageView()
            mediaStackView.addArrangedSubview(imageView)
            imageView.easy.layout(
                Width(UIScreen.main.bounds.width),
                Height(0.45 * UIScreen.main.bounds.height)
            )
            let imageRequest = ImageRequest(url: mediaUrl)
            Nuke.loadImage(with: imageRequest, into: imageView)
        }
        pageControl.numberOfPages = mediaUrls.count
        pageControl.isHidden = mediaUrls.count < 2
        
        usernameLabel.text = viewModel.username
        captionLabel.text = viewModel.caption
        timestampLabel.text = viewModel.timestamp
    }
}

// MARK: Private setup methods
private extension IGPostCell {
    func setup() {
        contentView.addSubview(stackView)
        
        mediaScrollView.easy.layout(Height(0.45 * UIScreen.main.bounds.height))
        
        mediaStackView.easy.layout(Edges())
        
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
private extension IGPostCell {
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            makeContainerView(for: usernameLabel),
            mediaScrollView,
            pageControl,
            makeContainerView(for: captionLabel),
            makeContainerView(for: timestampLabel)
        ])
        stackView.spacing = 7
        stackView.axis = .vertical
        return stackView
    }
    
    func makeMediaStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }
    
    func makeUsernameLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .regularBold
        return label
    }
    
    func makeMediaScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.addSubview(mediaStackView)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }
    
    func makeImageView() -> UIImageView {
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
    
    func makePageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.isHidden = true
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "0074B7")
        return pageControl
    }
    
    func makeContainerView(for view: UIView) -> UIView {
        let containerView = UIView()
        containerView.addSubview(view)
        return containerView
    }
}

extension IGPostCell: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

// MARK: Private helper methods
private extension IGPostCell {
    func setLabelConstraints(for label: UILabel) {
        label.easy.layout(
            Top(),
            Bottom(),
            Left(UIEdgeInsets.pageDefault.left),
            Right(UIEdgeInsets.pageDefault.right)
        )
    }
}

extension IGPostCell {
    struct ViewModel {
        let username: String
        let mediaUrl: URL
        let type: IGMediaType
        let caption: String
        let timestamp: String
    }
}
