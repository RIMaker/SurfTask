//
//  ChipsCell.swift
//  SurfTask
//
//  Created by Zhora Agadzhanyan on 05.02.2023.
//

import UIKit

class ChipsCell: UICollectionViewCell {
    
    static let cellIdentifier = "Cell"
    
    var chips: String? {
        didSet {
            if let chips = chips {
                DispatchQueue.main.async { [weak self] in
                    self?.name.text = chips
                }
            }
        }
    }
    
    var isActive: Bool = false {
        didSet {
            toggleColors()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                isActive.toggle()
            }
        }
    }
    
    private let name: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = ""
        lbl.textAlignment = .center
        lbl.textColor = R.color.darkTextColor()
        lbl.font = R.font.sfProDisplayMedium(size: 14)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(name)
        
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        name.topAnchor.constraint(equalTo:  contentView.topAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo:  contentView.bottomAnchor).isActive = true
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = R.color.inactiveChipsColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
    private func toggleColors() {
        if isActive {
            name.textColor = R.color.lightTextColor()
            contentView.backgroundColor = R.color.activeChipsColor()
        } else {
            name.textColor = R.color.darkTextColor()
            contentView.backgroundColor = R.color.inactiveChipsColor()
        }
    }
    
}
