//
//  CarouselModel.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 09.02.2023.
//

import Foundation

protocol CarouselModel {
    var items: [String]? { get set }
    func getWidth(at index: Int) -> CGFloat
    func getMaxWidth() -> CGFloat
}
