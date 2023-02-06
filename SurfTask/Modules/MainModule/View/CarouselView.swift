//
//  CarouselView.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 05.02.2023.
//

import UIKit

class CarouselView: UICollectionView {
    
    var items: [String]?
    
    private var selectedItems = Set<Int>()
    
    private let height: CGFloat = 44
    private let horizontalPadding: CGFloat = 48
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewLayout()) {
        let myLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        myLayout.itemSize = CGSize(width: 100, height: height)
        myLayout.scrollDirection = .horizontal
        myLayout.minimumLineSpacing = 12;
        
        super.init(frame: frame, collectionViewLayout: myLayout)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
    private func setup() {
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

// MARK: Delegate
extension CarouselView: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

extension CarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = items?[indexPath.item].width(font: R.font.sfProDisplayMedium(size: 14))
        return CGSize(width: (width ?? 0) + horizontalPadding, height: height)
    }
}
