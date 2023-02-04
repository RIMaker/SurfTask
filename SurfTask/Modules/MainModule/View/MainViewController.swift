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
        contentView: contentStackView,
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
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            mainDescription,
            secondaryDescription,
            spacer
        ])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
    }()
    
    override func loadView() {
        view = modalView as! ModalViewImpl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modalView.animateShowBackgroundView()
        modalView.animatePresentContainer()
    }
    
}

