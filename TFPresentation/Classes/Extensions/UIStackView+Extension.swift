//
//  UIStackView+Extension.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 02/12/2022.
//  Copyright © 2022 Triple. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach({
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
    }
}
