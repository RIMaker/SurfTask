//
//  ViewController.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 03.02.2023.
//

import UIKit

protocol MainViewController: AnyObject {
    func setupViews()
}

class MainViewControllerImpl: UIViewController, MainViewController {
    
    var presenter: MainPresenter?
    
    //MARK: Bottom view
    private lazy var bottomView: BottomView = {
        let bView = BottomView()
        
        return bView
    }()
    
    //MARK: Modal view
    private lazy var modalView: ModalView = ModalViewImpl(
        contentView: contentContainerView,
        backgroundViewImage: R.image.backgroundImage())
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplayBold(size: 24)
        label.textColor = R.color.darkTextColor()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        label.attributedText = NSMutableAttributedString(
            string: R.string.localization.mainViewTitle(),
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var mainDescription: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplayRegular(size: 14)
        label.textColor = R.color.thinTextColor()
        label.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        label.attributedText = NSMutableAttributedString(
            string: R.string.localization.mainDescription(),
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var secondaryDescription: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplayRegular(size: 14)
        label.textColor = R.color.thinTextColor()
        label.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        label.attributedText = NSMutableAttributedString(
            string: R.string.localization.secondaryDescription(),
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var carouselView: CarouselView = {
        let carousel = CarouselView(frame: .zero)
        carousel.items = presenter?.chips
        return carousel
    }()
    
    private lazy var doubleCarouselView: DoubleCarouselView = {
        let carousel = DoubleCarouselView(frame: .zero)
        carousel.items = presenter?.chips
        return carousel
    }()
    
    private lazy var contentContainerView: ContainerView = {
        let spacer = UIView()
        let container = ContainerView()
        container.add(subview: titleLabel, topPadding: 24, leadingPadding: 20, trailingPadding: 20)
        container.add(subview: mainDescription, topPadding: 12, leadingPadding: 20, trailingPadding: 20)
        container.add(subview: carouselView, topPadding: 12)
        container.add(subview: secondaryDescription, topPadding: 24, leadingPadding: 20, trailingPadding: 20)
        container.add(subview: doubleCarouselView, topPadding: 12)
        container.add(subview: spacer, bottomPadding: -118)
        
        container.backgroundColor = R.color.mainViewBackgroundColor()
        return container
    }()
    
    override func loadView() {
        view = modalView as? ModalViewImpl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewShown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modalView.animate()
    }
    
    func setupViews() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 118)
        ])
    }
}

