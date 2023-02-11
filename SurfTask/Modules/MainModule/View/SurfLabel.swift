//
//  DescriptionLabel.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 07.02.2023.
//

import UIKit

enum SurfLabelType {
    case description
    case title
}

class SurfLabel: UILabel {
    
    private var myText: String
    private var type: SurfLabelType
    
    init(withText text: String, type: SurfLabelType) {
        self.myText = text
        self.type = type
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        let paragraphStyle = NSMutableParagraphStyle()
        switch type {
        case .description:
            font = R.font.sfProDisplayRegular(size: 14)
            textColor = R.color.thinTextColor()
            numberOfLines = 0
            paragraphStyle.lineHeightMultiple = 1.2
            
        case .title:
            font = R.font.sfProDisplayBold(size: 24)
            textColor = R.color.darkTextColor()
            paragraphStyle.lineHeightMultiple = 1.12
        }
        attributedText = NSMutableAttributedString(
            string: myText,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }

}
