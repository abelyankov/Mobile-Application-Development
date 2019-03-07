//
//  TagColorCollecrtionViewCell.swift
//  GetContact
//
//  Created by Belyankov Arthurs on 3/7/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit


class TagColorCollecrtionViewCell: UICollectionViewCell {
    
    lazy var selectedIndicator: UIView = {
        let view = UILabel()
        view.text = "✓"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 36)
        view.textAlignment = .center
        return view
    }()
    
    var tagColor: TagColor? {
        didSet {
            backgroundColor = tagColor?.color
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                addSubview(selectedIndicator)
                selectedIndicator.frame = bounds
            } else {
                selectedIndicator.removeFromSuperview()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height)/2
    }
}
