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
    
    var carouselModel: CarouselModel? {
        didSet {
            if let items = carouselModel?.items {
                if items.count > 10 {
                    carouselModel?.items = Array(items[0..<10])
                }
            }
        }
    }
    
    private var selectedItems = Set<Int>()
    
    private let height: CGFloat = 44
    
    private var minContentOffset: CGPoint {
        guard let firstItemWidth = carouselModel?.getWidth(at: 0) else { return CGPoint(x: 0, y: 0) }
        return CGPoint(
            x: firstItemWidth - 8,
            y: -contentInset.top)
    }
    
    private var maxContentOffset: CGPoint {
        guard
            let items = carouselModel?.items,
            let lastItemWidth = carouselModel?.getWidth(at: items.count - 1)
        else { return CGPoint(x: 0, y: 0) }
        return CGPoint(
            x: contentSize.width - bounds.width - lastItemWidth + 8,
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
        isInfiniteScrollable { [weak self] result in
            if result {
                DispatchQueue.main.async { [weak self] in
                    guard let welf = self else { return }
                    welf.setContentOffset(welf.minContentOffset, animated: animated)
                }
            }
        }
    }
    
    private func isInfiniteScrollable(complete: @escaping (Bool)->()) {
        if let carouselModel = carouselModel {
            carouselModel.getMaxWidth { [weak self] maxWidth in
                DispatchQueue.main.async { [weak self] in
                    guard let welf = self else {
                        complete(false)
                        return
                    }
                    complete(!((welf.contentSize.width - maxWidth + 8) < welf.bounds.width))
                }
            }
        } else {
            complete(false)
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
        isInfiniteScrollable { [weak self] result in
            if result {
                let queue = DispatchQueue(label: "com.scrollViewDidScroll", qos: .userInteractive)
                DispatchQueue.main.async { [weak self] in
                    guard let welf = self else { return }
                    switch welf.contentOffset.x {
                    case ...(-20):
                        queue.async { [weak self] in
                            let last = self?.carouselModel?.items?.removeLast()
                            guard let last = last, let count = self?.carouselModel?.items?.count else { return }
                            self?.carouselModel?.items?.insert(last, at: 0)
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
                    case (welf.contentSize.width - welf.bounds.width + 20)...:
                        queue.async { [weak self] in
                            let first = self?.carouselModel?.items?.removeFirst()
                            guard let first = first, let count = self?.carouselModel?.items?.count else { return }
                            self?.carouselModel?.items?.append(first)
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
    }
}

// MARK: Delegate
extension CarouselViewImpl: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = carouselModel?.items?.count {
            return count > 10 ? 10: count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipsCell.cellIdentifier, for: indexPath) as! ChipsCell
            
        myCell.chips = carouselModel?.items?[indexPath.item]
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
        let width = carouselModel?.getWidth(at: indexPath.item)
        return CGSize(width: (width ?? 0), height: height)
    }
}
