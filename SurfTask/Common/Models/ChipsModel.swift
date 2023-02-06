//
//  ChipsModel.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 05.02.2023.
//

import Foundation

class ChipsModel {
    
    static let shared = ChipsModel()
    
    let items: [String] = [
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
    
    private init() {}
}
