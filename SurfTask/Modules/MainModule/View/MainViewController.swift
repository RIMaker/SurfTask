//
//  ViewController.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 03.02.2023.
//

import UIKit

protocol MainViewController {
    
}

class MainViewControllerImpl: UIViewController, MainViewController {
    
    lazy var modalView: ModalView = ModalViewImpl(
        contentView: contentContainerView,
        backgroundViewImage: R.image.backgroundImage())
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localization.mainViewTitle()
        label.font = R.font.sfProDisplayBold(size: 24)
        label.textColor = R.color.darkTextColor()
        return label
    }()
    
    lazy var mainDescription: UILabel = {
        let label = UILabel()
        label.text = R.string.localization.mainDescription()
        label.font = R.font.sfProDisplayRegular(size: 14)
        label.textColor = R.color.thinTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var secondaryDescription: UILabel = {
        let label = UILabel()
        label.text = R.string.localization.secondaryDescription()
        label.font = R.font.sfProDisplayRegular(size: 14)
        label.textColor = R.color.thinTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var carouselView: UICollectionView = {
        let carousel = CarouselView(frame: .zero)
        return carousel
    }()
    
    lazy var contentContainerView: ContainerView = {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modalView.animate()
    }
    
}

