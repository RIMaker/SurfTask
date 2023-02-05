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
        label.text = R.string.localization.mainViewTitle()
        label.font = R.font.sfProDisplayBold(size: 24)
        label.textColor = R.color.darkTextColor()
        return label
    }()
    
    private lazy var mainDescription: UILabel = {
        let label = UILabel()
        label.text = R.string.localization.mainDescription()
        label.font = R.font.sfProDisplayRegular(size: 14)
        label.textColor = R.color.thinTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondaryDescription: UILabel = {
        let label = UILabel()
        label.text = R.string.localization.secondaryDescription()
        label.font = R.font.sfProDisplayRegular(size: 14)
        label.textColor = R.color.thinTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var carouselView: UICollectionView = {
        let carousel = CarouselView(frame: .zero)
        carousel.items = ChipsModel.shared.items
        return carousel
    }()
    
    private lazy var contentContainerView: ContainerView = {
        let spacer = UIView()
        let container = ContainerView()
        container.add(subview: titleLabel, topPadding: 24, leadingPadding: 20, trailingPadding: 20)
        container.add(subview: mainDescription, topPadding: 12, leadingPadding: 20, trailingPadding: 20)
        container.add(subview: carouselView, topPadding: 12)
        container.add(subview: secondaryDescription, topPadding: 24, leadingPadding: 20, trailingPadding: 20)
        container.add(subview: spacer, bottomPadding: 0)
        
        container.backgroundColor = R.color.mainViewBackgroundColor()
        return container
    }()
    
    override func loadView() {
        view = modalView as! ModalViewImpl
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

