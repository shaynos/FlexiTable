//
//  SegmentedHeaderCollectionViewCell.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit

open class SegmentedHeaderCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel
    
    override init(frame: CGRect){
        titleLabel = UILabel.init(frame: frame)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        super.init(frame: frame)
        self.addSubview(titleLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    public func setTitle(title: String, font: UIFont){
        titleLabel.text = title
        titleLabel.font = font
    }
    
    override open func updateConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        super.updateConstraints()
    }
    
}
