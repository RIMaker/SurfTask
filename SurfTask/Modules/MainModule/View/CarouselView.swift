//
//  CarouselView.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 05.02.2023.
//

import UIKit

protocol CarouselView {
    func scrollToMinContentOffset(animated: Bool)
}

class CarouselViewImpl: UICollectionView, CarouselView {
    
    var items: [String]? {
        didSet {
            if let items = items {
                if items.count > 10 {
                    self.items = Array(items[0..<10])
                }
                if firstItem == nil {
                    firstItem = items[0]
                }
            }
        }
    }
    
    private var firstItem: String?
    
    private var selectedItems = Set<Int>()
    
    private let height: CGFloat = 44
    private let horizontalPadding: CGFloat = 48
    
    private var minContentOffset: CGPoint {
        let firstItemWidth = items?.first?.width(font: R.font.sfProDisplayMedium(size: 14)) ?? 0
        return CGPoint(
            x: horizontalPadding + firstItemWidth - 8,
            y: -contentInset.top)
    }
    
    private var isInfiniteScrollable: Bool {
        if let firstItemWidth = firstItem?.width(font: R.font.sfProDisplayMedium(size: 14)) {
            return !((contentSize.width - firstItemWidth - horizontalPadding) < bounds.width)
        } else {
            return false
        }
    }
    
    private var maxContentOffset: CGPoint {
        let lastItemWidth = items?.last?.width(font: R.font.sfProDisplayMedium(size: 14)) ?? 0
        return CGPoint(
            x: contentSize.width - bounds.width - horizontalPadding - lastItemWidth + 8,
            y: contentSize.height - bounds.height + contentInset.bottom)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewLayout()) {
        let myLayout = UICollectionViewFlowLayout()
        myLayout.itemSize = CGSize(width: 100, height: height)
        myLayout.scrollDirection = .horizontal
        myLayout.minimumLineSpacing = 12;
        
        super.init(frame: frame, collectionViewLayout: myLayout)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
    func scrollToMinContentOffset(animated: Bool) {
        if isInfiniteScrollable {
            setContentOffset(minContentOffset, animated: animated)
        }
    }
    
    private func scrollToMaxContentOffset(animated: Bool) {
        setContentOffset(maxContentOffset, animated: animated)
    }
    
    private func setup() {
        contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        backgroundColor = R.color.mainViewBackgroundColor()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        dataSource = self
        delegate = self
        register(ChipsCell.self, forCellWithReuseIdentifier: ChipsCell.cellIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

// MARK: ScrollView delegate
extension CarouselViewImpl {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isInfiniteScrollable {
            let queue = DispatchQueue(label: "myQueue", qos: .userInteractive)
            switch contentOffset.x {
            case ...(-20):
                queue.async { [weak self] in
                    let last = self?.items?.removeLast()
                    guard let last = last, let count = self?.items?.count else { return }
                    self?.items?.insert(last, at: 0)
                    self?.selectedItems = Set(self?.selectedItems.map{
                        ($0 == count) ? ($0 - count): $0 + 1
                    } ?? [])
                    DispatchQueue.main.async { [weak self] in
                        UIView.performWithoutAnimation {
                            self?.reloadData()
                            self?.scrollToMinContentOffset(animated: false)
                        }
                    }
                }
            case (contentSize.width - bounds.width + 20)...:
                queue.async { [weak self] in
                    let first = self?.items?.removeFirst()
                    guard let first = first, let count = self?.items?.count else { return }
                    self?.items?.append(first)
                    self?.selectedItems = Set(self?.selectedItems.map{
                        ($0 == 0) ? count: $0 - 1
                    } ?? [])
                    DispatchQueue.main.async { [weak self] in
                        UIView.performWithoutAnimation {
                            self?.reloadData()
                            self?.scrollToMaxContentOffset(animated: false)
                        }
                    }
                }
            default: break
            }
        }
    }
}

// MARK: Delegate
extension CarouselViewImpl: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = items?.count {
            return count > 10 ? 10: count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipsCell.cellIdentifier, for: indexPath) as! ChipsCell
            
        myCell.chips = items?[indexPath.item]
        if selectedItems.contains(indexPath.item) {
            myCell.isActive = true
        } else {
            myCell.isActive = false
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedItems.contains(indexPath.item) {
            selectedItems.remove(indexPath.item)
        } else {
            selectedItems.insert(indexPath.item)
        }
    }
}

extension CarouselViewImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = items?[indexPath.item].width(font: R.font.sfProDisplayMedium(size: 14))
        return CGSize(width: (width ?? 0) + horizontalPadding, height: height)
    }
}
