//
//  ModalView.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 04.02.2023.
//

import UIKit

protocol ModalView {
    func animatePresentContainer()
    func animateShowBackgroundView()
}

class ModalViewImpl: UIView, ModalView {
    
    private var contentView: UIView
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.mainViewBackgroundColor()
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var maximumContainerHeight: CGFloat
    private let maxBackgroundAlpha: CGFloat = 1
    
    private let defaultHeight: CGFloat = 334
    private var currentContainerHeight: CGFloat = 334
    
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    init(
        contentView: UIView,
        backgroundViewImage: UIImage?)
    {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        self.maximumContainerHeight = UIScreen.main.bounds.height - statusBarHeight
        self.contentView = contentView
        
        super.init(frame: CGRect())
        self.backgroundView.image = backgroundViewImage
        setupView()
        setupConstraints()
        setupPanGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    func animateShowBackgroundView() {
        backgroundView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = self.maxBackgroundAlpha
        }
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        addSubview(backgroundView)
        addSubview(containerView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -198),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
    
            contentView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: defaultHeight)
      
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        addGestureRecognizer(panGesture)
    }
    
    // MARK: Pan gesture handler
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        let isDraggingDown = translation.y > 0
        
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
            case .changed:
                if newHeight < maximumContainerHeight && newHeight > defaultHeight {
                    containerViewHeightConstraint?.constant = newHeight
                    layoutIfNeeded()
                }
            case .ended:
                if newHeight < maximumContainerHeight && isDraggingDown {
                    animateContainerHeight(defaultHeight)
                } else if newHeight > defaultHeight && !isDraggingDown {
                    animateContainerHeight(maximumContainerHeight)
                }
            default:
                break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.layoutIfNeeded()
        }
        currentContainerHeight = height
    }

}
