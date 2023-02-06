//
//  String + width.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 06.02.2023.
//

import UIKit

extension String {
    func width(font: UIFont?) -> CGFloat {
        guard let font = font else { return 0 }
        return self.size(withAttributes: [
            NSAttributedString.Key.font : font
        ]).width.rounded(.up)
    }
}
