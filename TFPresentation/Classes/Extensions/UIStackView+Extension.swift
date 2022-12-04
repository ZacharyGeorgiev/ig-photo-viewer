//
//  UIStackView+Extension.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 02/12/2022.
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
