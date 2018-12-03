//
//  ParallaxHeaderView.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit

public enum parallaxHeaderPosition {
    case top
    case center
    case bottom
}

public class ParallaxHeaderView: FlexiTableForegroundBackgroundView {
    
    public let headerLabel = UILabel()
    let labelTopConstraint = NSLayoutConstraint()
    let headerPosition: parallaxHeaderPosition
    
    public init(title: String, font: UIFont, textColor: UIColor, headerPosition: parallaxHeaderPosition){
        headerLabel.text = title
        headerLabel.font = font
        headerLabel.textColor = textColor
        headerLabel.textAlignment = .center
        self.headerPosition = headerPosition
        
        super.init(frame: CGRect.zero)
        
        self.addSubview(headerLabel)
        
    }
    
    override open func layoutSubviews() {
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor .constraint(equalTo: self.leadingAnchor, constant: 35).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true

        switch headerPosition {
        case .top:
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        case .center:
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        case .bottom:
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
