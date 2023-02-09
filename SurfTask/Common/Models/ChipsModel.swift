//
//  ChipsModel.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 05.02.2023.
//

import Foundation

struct ChipsModel: CarouselModel {
    
    var items: [String]? = [
        R.string.localization.chipIOS(),
        R.string.localization.chipAndroid(),
        R.string.localization.chipDesign(),
        R.string.localization.chipQA(),
        R.string.localization.chipFlutter(),
        R.string.localization.chipPM(),
        R.string.localization.chipAnalitic(),
        R.string.localization.chipML(),
        R.string.localization.chipBackend(),
        R.string.localization.chipFrontend()
    ]
    
    private let horizontalPadding: CGFloat = 48
    
    func getWidth(at index: Int) -> CGFloat {
        guard let items = items, index < items.count else { return 0 }
        return items[index].width(font: R.font.sfProDisplayMedium(size: 14)) + horizontalPadding
    }
    
    func getMaxWidth() -> CGFloat {
        guard let items = items else { return 0 }
        var maxWidth: CGFloat = 0
        for i in 0..<items.count {
            maxWidth = max(maxWidth, getWidth(at: i))
        }
        return maxWidth
    }
    
}
