//
//  UIView+Extension.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 04/12/2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach({ addSubview($0) })
    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ addSubview($0) })
    }
}
