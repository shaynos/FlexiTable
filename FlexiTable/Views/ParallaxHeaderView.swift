//
//  ParallaxHeaderView.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit

class ParallaxHeaderView: FlexiTableForegroundBackgroundView {
    
    let headerLabel = UILabel()
    let labelTopConstraint = NSLayoutConstraint()
    
    init(title: String, font: UIFont, textColor: UIColor){
        headerLabel.text = title
        headerLabel.font = font
        headerLabel.textColor = textColor
        headerLabel.textAlignment = .center
        super.init(frame: CGRect.zero)
        
        self.addSubview(headerLabel)
        
    }
    
    override func layoutSubviews() {
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor .constraint(equalTo: self.leadingAnchor, constant: 35).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
