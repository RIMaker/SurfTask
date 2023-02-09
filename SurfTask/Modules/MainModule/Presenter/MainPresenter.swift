//
//  MainPresenter.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 03.02.2023.
//

import Foundation

protocol MainPresenter {
    var chips: CarouselModel? { get }
    init(view: MainViewController?, chips: CarouselModel?)
    func viewShown()
}

class MainPresenterImpl: MainPresenter {
    
    var chips: CarouselModel?
    
    private weak var view: MainViewController?
    
    required init(view: MainViewController?, chips: CarouselModel?) {
        self.view = view
        self.chips = chips
    }
    
    func viewShown() {
        view?.setupViews()
    }
    
}
