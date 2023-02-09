//
//  ViewFactory.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 03.02.2023.
//

import UIKit

enum ScreenIdentifier {
    case mainScreen
    case launchScreen
}

protocol ViewFactory {
    func makeView(for screenIdentifier: ScreenIdentifier) -> UIViewController?
}

class ViewFactoryImpl: ViewFactory {
    
    func makeView(for screenIdentifier: ScreenIdentifier) -> UIViewController? {
        switch screenIdentifier {
        case .mainScreen: return makeMainScreen()
        case .launchScreen: return makeLaunchScreen()
        }
    }
}

// MARK: - Supporting functions
extension ViewFactoryImpl {
    func makeMainScreen() -> UIViewController {
        let mainVC = MainViewControllerImpl()
        let presenter = MainPresenterImpl(view: mainVC, chips: ChipsModel())
        mainVC.presenter = presenter
        return mainVC
    }
    
    func makeLaunchScreen() -> UIViewController? {
        let launchScreen = R.storyboard.launchScreen.instantiateInitialViewController()
        return launchScreen
    }
}
