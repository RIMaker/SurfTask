//
//  MainPresenter.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 03.02.2023.
//

import Foundation

protocol MainPresenter {
    var chips: [String]? { get }
    init(view: MainViewController?, chips: [String]?)
    func viewShown()
}

class MainPresenterImpl: MainPresenter {
    
    var chips: [String]?
    
    private weak var view: MainViewController?
    
    required init(view: MainViewController?, chips: [String]?) {
        self.view = view
        self.chips = chips
    }
    
    func viewShown() {
        view?.setupViews()
    }
    
}
