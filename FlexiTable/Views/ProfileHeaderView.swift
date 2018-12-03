//
//  ProfileHeaderView.swift
//  FlexiTable
//
//  Created by Shayne Brady on 1/12/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit

public class ProfileHeaderView: FlexiHeaderView {
    var maxImageHeight: CGFloat?
    let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let subtitleLabel = UILabel()
    
    public init(maxImageHeight: CGFloat, image: UIImage, title: String, subtitle: String) {
        self.maxImageHeight = maxImageHeight
        self.imageView.image = image
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.clear
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor).isActive = true
        imageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8).isActive = true
    imageView.heightAnchor.constraint(lessThanOrEqualToConstant: maxImageHeight).isActive = true


        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        
    }
    
    override public func flexiTableDidScroll(offset: CGFloat) {
        subtitleLabel.alpha = 1 - offset / 100
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }
    
    override public func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }
    
    override public func updateConstraints() {
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        super.updateConstraints()
    }
}
