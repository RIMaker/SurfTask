//
//  MainPresenter.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 03.02.2023.
//

import Foundation

protocol MainPresenter {
    func viewShown()
    init(view: MainViewController?)
}

class MainPresenterImpl: MainPresenter {
    
    private weak var view: MainViewController?
    
    required init(view: MainViewController?) {
        self.view = view
    }
    
    func viewShown() {
        view?.setupViews()
    }
    
}
