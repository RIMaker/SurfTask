//
//  ContainerView.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 05.02.2023.
//

import UIKit

class ContainerView: UIView {
    
    func add(
        subview: UIView,
        topPadding: CGFloat = 0,
        bottomPadding: CGFloat? = nil,
        leadingPadding: CGFloat = 0,
        trailingPadding: CGFloat = 0)
    {
        let view = subviews.last ?? self
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(
                equalTo: view == self ? view.topAnchor: view.bottomAnchor,
                constant: topPadding
            ),
            subview.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: leadingPadding
            ),
            subview.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -trailingPadding
            )
        ])
        if let bottomPadding = bottomPadding {
            subview.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -bottomPadding)
            .isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }

}
