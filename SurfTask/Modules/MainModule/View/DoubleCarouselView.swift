//
//  DoubleCarouselView.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 06.02.2023.
//

import UIKit

class DoubleCarouselView: UIScrollView {
    
    var carouselModel: CarouselModel? {
        didSet {
            var i: CGFloat = 0
            while let view = getPage(withNumber: i) {
                addSubview(view)
                i += 1
            }
            contentSize = CGSize(width: i * screenWidth, height: scrollViewHeight)
        }
    }
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width

    private let itemHeight: CGFloat = 44
    private let scrollViewHeight: CGFloat = 100
    private let horizontalSelfPadding: CGFloat = 20
    private let paddingBetweenItems : CGFloat = 12
    private var contentWidth: CGFloat = 0
    private var lineNumber = 1
    private var itemIndex = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        isPagingEnabled = true
        backgroundColor = R.color.mainViewBackgroundColor()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func getPage(withNumber number: CGFloat) -> UIView? {
        guard let items = carouselModel?.items, itemIndex < items.count else { return nil }
        
        let view = UIView(frame: CGRect(x: number * screenWidth, y: 0, width: screenWidth, height: scrollViewHeight))
        
        var itemWidth = carouselModel?.getWidth(at: itemIndex)
        var flag = true
        while itemIndex < items.count && flag {
            switch lineNumber {
            case 1:
                //прибавил лишнее
                var size = contentWidth + horizontalSelfPadding + paddingBetweenItems + (itemWidth ?? 0)
                while size <= screenWidth && itemIndex < items.count {
                    let carouselItem = button(for: itemIndex, originY: 0)
                    view.addSubview(carouselItem)
                    //отнял лишнее
                    contentWidth = size - (contentWidth == 0 ? paddingBetweenItems: horizontalSelfPadding)
                    itemIndex += 1
                    guard itemIndex < items.count else { break }
                    itemWidth = carouselModel?.getWidth(at: itemIndex)
                    size = contentWidth + horizontalSelfPadding + paddingBetweenItems + (itemWidth ?? 0)
                }
                contentWidth = 0
                lineNumber = 2
            case 2:
                //прибавил лишнее
                var size = contentWidth + horizontalSelfPadding + paddingBetweenItems + (itemWidth ?? 0)
                while size <= screenWidth && itemIndex < items.count {
                    let carouselItem = button(for: itemIndex, originY: itemHeight + paddingBetweenItems)
                    view.addSubview(carouselItem)
                    //отнял лишнее
                    contentWidth = size - (contentWidth == 0 ? paddingBetweenItems: horizontalSelfPadding)
                    itemIndex += 1
                    guard itemIndex < items.count else { break }
                    itemWidth = carouselModel?.getWidth(at: itemIndex)
                    size = contentWidth + horizontalSelfPadding + paddingBetweenItems + (itemWidth ?? 0)
                }
                contentWidth = 0
                lineNumber = 1
                flag = false
            default: break
            }
        }
        return view
    }
    
    private func button(for itemIndex: Int, originY: CGFloat) -> UIButton {
        guard
            let itemWidth = carouselModel?.getWidth(at: itemIndex),
            let itemTitle = carouselModel?.items?[itemIndex]
        else { return UIButton() }
        let btn = DoubleCarouselButton(frame: CGRect(
            x: contentWidth + (contentWidth == 0 ? horizontalSelfPadding: paddingBetweenItems),
            y: originY,
            width: itemWidth,
            height: itemHeight))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.alignment = NSTextAlignment.center
        let text = NSMutableAttributedString(
            string: itemTitle,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        btn.setAttributedTitle(text, for: .normal)
        return btn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }

}

class DoubleCarouselButton: UIButton {
    
    private var isActive = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        titleLabel?.font = R.font.sfProDisplayMedium(size: 14)
        setTitleColor(R.color.darkTextColor(), for: .normal)
        backgroundColor = R.color.inactiveChipsColor()
        layer.cornerRadius = 12
        clipsToBounds = true
        addTarget(self, action: #selector(onTapped), for: .touchUpInside)
    }
    
    @objc
    private func onTapped(_ sender: UIButton) {
        isActive.toggle()
        if isActive {
            setTitleColor(R.color.lightTextColor(), for: .normal)
            backgroundColor = R.color.activeChipsColor()
        } else {
            setTitleColor(R.color.darkTextColor(), for: .normal)
            backgroundColor = R.color.inactiveChipsColor()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
}
