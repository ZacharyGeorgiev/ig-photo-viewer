////
////  UIStackView+Extension.swift
////  TFPresentation
////
////  Created by Zahari Georgiev on 29/11/2022.
////  Copyright © 2022 Triple. All rights reserved.
////
//
//import UIKit
//
//extension UIStackView {
//    
//    func removeAllArrangedSubviews() {
//        arrangedSubviews.forEach({
//            removeArrangedSubview($0)
//            $0.removeFromSuperview()
//        })
//    }
//    
//    func addArrangedSubviews(_ arrangedSubviews: UIView...) {
//        arrangedSubviews.forEach({ addArrangedSubview($0) })
//    }
//    
//    func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
//        arrangedSubviews.forEach({ addArrangedSubview($0) })
//    }
//    
//    func addArrangedSubviews(_ arrangedSubviews: [UIView], separatorBuilder buildSeparator: () -> UIView) {
//        for (index, arrangedSubview) in arrangedSubviews.enumerated() {
//            addArrangedSubview(arrangedSubview)
//            if index < arrangedSubviews.count - 1 {
//                addArrangedSubview(buildSeparator())
//            }
//        }
//    }
//    
//    func set(elements: Element...) {
//        removeAllArrangedSubviews()
//        elements.forEach({ add(element: $0) })
//    }
//    
//    func set(elements: [Element]) {
//        removeAllArrangedSubviews()
//        elements.forEach({ add(element: $0) })
//    }
//    
//    func setArrangedSubviews(_ views: UIView...) {
//        removeAllArrangedSubviews()
//        views.forEach({ addArrangedSubview($0) })
//    }
//    
//    func setArrangedSubviews(_ views: [UIView]) {
//        removeAllArrangedSubviews()
//        views.forEach({ addArrangedSubview($0) })
//    }
//    
//    func add(elements: Element...) {
//        elements.forEach({ add(element: $0) })
//    }
//    
//    func add(elements: [Element]) {
//        elements.forEach({ add(element: $0) })
//    }
//    
//    func add(element: Element, at index: Int? = nil) {
//        switch element {
//        case .view(let view, let trailingSpace, let insets, let alignment):
//            let viewToInsert: UIView
//            if let insets = insets {
//                viewToInsert = ViewContainer(
//                    with: view,
//                    insets: insets,
//                    alignment: containerAlignment(for: alignment),
//                    hidesWhenContainedViewHides: true
//                )
//            } else if let alignment = alignment {
//                viewToInsert = ViewContainer(
//                    with: view,
//                    alignment: containerAlignment(for: alignment),
//                    hidesWhenContainedViewHides: true
//                )
//            } else {
//                viewToInsert = view
//            }
//            if let index = index {
//                insertArrangedSubview(viewToInsert, at: index)
//            } else {
//                addArrangedSubview(viewToInsert)
//            }
//            if let trailingSpace = trailingSpace {
//                setCustomSpacing(trailingSpace, after: viewToInsert)
//            }
//        case .space(let amount):
//            if let index = index {
//                insertArrangedSubview(axis == .vertical ? CMSpacer(height: amount) : CMSpacer(width: amount), at: index)
//            } else {
//                addArrangedSubview(axis == .vertical ? CMSpacer(height: amount) : CMSpacer(width: amount))
//            }
//        case .scrollViewFiller(let minimumHeight, let maximumHeight, let view):
//            if let index = index {
//                insertArrangedSubview(ScrollViewFiller(minimumHeight: minimumHeight, maximumHeight: maximumHeight, containedView: view), at: index)
//            } else {
//                addArrangedSubview(ScrollViewFiller(minimumHeight: minimumHeight, maximumHeight: maximumHeight, containedView: view))
//            }
//        }
//    }
//    
//    convenience init(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, elements: [Element] = []) {
//        self.init()
//        self.axis = axis
//        self.spacing = spacing
//        set(elements: elements)
//    }
//}
//
//extension UIStackView {
//    
//    enum Element: Equatable {
//        case view(_ view: UIView, trailingSpace: CGFloat? = nil, insets: UIEdgeInsets? = nil, alignment: CrossAxisAlignment? = nil)
//        case space(_ amount: CGFloat)
//        
//        /// Use only 1 of these per scroll view
//        case scrollViewFiller(minimumHeight: CGFloat, maximumHeight: CGFloat? = nil, view: UIView? = nil)
//        
//        enum CrossAxisAlignment {
//            case start
//            case end
//            case center
//            case stretch
//        }
//    }
//    
//    private func containerAlignment(for alignment: Element.CrossAxisAlignment?) -> ViewContainer.Alignment {
//        guard let alignment = alignment else { return .stretch }
//        switch alignment {
//        case .start:
//            return axis == .horizontal ? .top : .left
//        case .end:
//            return axis == .horizontal ? .bottom : .right
//        case .center:
//            return axis == .horizontal ? .centerVertically : .centerHorizontally
//        case .stretch:
//            return .stretch
//        }
//    }
//}
