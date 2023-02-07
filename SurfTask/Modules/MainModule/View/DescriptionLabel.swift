//
//  DescriptionLabel.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 07.02.2023.
//

import UIKit

class DescriptionLabel: UILabel {
    
    private var myText: String
    
    init(with text: String) {
        myText = text
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        font = R.font.sfProDisplayRegular(size: 14)
        textColor = R.color.thinTextColor()
        numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        attributedText = NSMutableAttributedString(
            string: myText,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }

}
