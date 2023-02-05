//
//  BottomView.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 05.02.2023.
//

import UIKit

class BottomView: UIView {
    
    private lazy var primaryButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(R.string.localization.primaryButtonTitle(), for: .normal)
        btn.titleLabel?.font = R.font.sfProDisplayMedium(size: 16)
        btn.setTitleColor(R.color.lightTextColor(), for: .normal)
        btn.backgroundColor = R.color.primaryButtonColor()
        btn.layer.cornerRadius = 30
        btn.clipsToBounds = true
        return btn
    }()
    
    private lazy var primaryDescription: UILabel = {
        let lbl = UILabel()
        lbl.text = R.string.localization.primaryButtonDescription()
        lbl.font = R.font.sfProDisplayRegular(size: 14)
        lbl.textColor = R.color.thinTextColor()
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
    private func setup() {
        backgroundColor = R.color.mainViewBackgroundColor()
        addSubview(primaryButton)
        addSubview(primaryDescription)
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            primaryButton.topAnchor.constraint(equalTo: topAnchor),
            primaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            primaryButton.heightAnchor.constraint(equalToConstant: 60),
            primaryButton.widthAnchor.constraint(equalToConstant: 219),
            primaryDescription.centerYAnchor.constraint(equalTo: primaryButton.centerYAnchor),
            primaryDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            primaryDescription.trailingAnchor.constraint(lessThanOrEqualTo: primaryButton.leadingAnchor, constant: -24),
            primaryDescription.widthAnchor.constraint(equalToConstant: 92)
        ])
        primaryButton.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func onButtonTapped(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showAlert(
            title: R.string.localization.primaryButtonAlertTitle(),
            message: R.string.localization.primaryButtonAlertMessage(),
            actionTitle: R.string.localization.primaryButtonAlertActionTitle()
        )
    }
}
