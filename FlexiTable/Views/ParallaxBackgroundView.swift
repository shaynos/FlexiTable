//
//  ParallaxBackgroundView.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit

public class ParallaxBackgroundView: FlexiHeaderView {
    let imageView: UIImageView
    let dimmerView = UIView()
    
    public init(image: UIImage){
        imageView = UIImageView.init(frame: CGRect.zero)
        imageView.image = image
        imageView.backgroundColor = UIColor.orange
        super.init(frame: CGRect.zero)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
     
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
