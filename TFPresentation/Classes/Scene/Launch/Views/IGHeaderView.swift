//
//  IGHeaderView.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 28/11/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class IGHeaderView: UIView {
    // MARK: Private properties
    private lazy var logoImageView: UIImageView = makeLogoImageView()
    
    // MARK: Lifecycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
}

private extension IGHeaderView {
    func setup() {
        addSubview(logoImageView)
        
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "DDDDDD").cgColor
        
        logoImageView.easy.layout(
            Top(10).to(safeAreaLayoutGuide, .top),
            Left(15),
            Height(45),
            Width(120),
            Bottom(8)
        )
    }
}

// MARK: Factory
private extension IGHeaderView {
    func makeLogoImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "igLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
