//
//  SegmentedHeaderView.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit

public protocol SegmentedHeaderDelegate: AnyObject {
    func segmentedHeaderViewSelectedButtonAtIndex(index: NSInteger, title: String)
    func segmentedHeaderShouldSelectSegement(atIndex: NSInteger, fromIndex: NSInteger) -> Bool
}

open class SegmentedHeaderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    public weak var delegate: SegmentedHeaderDelegate?

    let segmentTitles: NSArray
    let viewHeight: CGFloat
    let minimumHorizontalPadding: CGFloat
    
    public var buttonFont: (UIFont) = UIFont.systemFont(ofSize: 16)
    
    var segmentCollectionView: UICollectionView
    var indicatorView: UIView = UIView()
    var hasScrolled: Bool = false
    
    public var selectedColor = UIColor.black
    public var deselectedColor = UIColor.lightGray
    
    var indicatorLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var indicatorWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    var selectedIndex: NSInteger = 0
    
    var staticCollectionViewWidth: Bool = false
    var collectionViewCellWidth: CGFloat = 0
    
    public init(segmentTitles: NSArray, viewHeight: CGFloat, horizontalPadding: CGFloat){
        print("INITING SEG")
        self.segmentTitles = segmentTitles
        self.viewHeight = viewHeight
        self.minimumHorizontalPadding = horizontalPadding
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.estimatedItemSize = CGSize(width: 100, height: viewHeight)
        flowLayout.scrollDirection = .horizontal
        
        segmentCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: viewHeight - 2), collectionViewLayout: flowLayout)
        
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: viewHeight))
        
        segmentCollectionView.dataSource = self
        segmentCollectionView.delegate = self
        segmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        segmentCollectionView.register(SegmentedHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "segCell")
        segmentCollectionView.backgroundColor = UIColor.white
        segmentCollectionView.showsHorizontalScrollIndicator = false
        
        let collectionViewInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        segmentCollectionView.contentInset = collectionViewInsets
        
        self.addSubview(segmentCollectionView)
        
        indicatorView = UIView.init(frame: CGRect.zero)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = selectedColor
        self.addSubview(indicatorView)
        
        indicatorLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        indicatorLeadingConstraint.isActive = true
        
        self.backgroundColor = deselectedColor
        checkCollectionViewCellWidth()
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func updateConstraints() {
        print("laying out constraints")
        self.widthAnchor.constraint(equalTo: (self.superview?.widthAnchor)!, multiplier: 1).isActive = true
        self.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        self.centerXAnchor.constraint(equalTo: (self.superview?.centerXAnchor)!).isActive = true

        segmentCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        segmentCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        segmentCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        segmentCollectionView.heightAnchor.constraint(equalToConstant: viewHeight - 2).isActive = true
        
        indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        if (staticCollectionViewWidth) {
            indicatorWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: collectionViewCellWidth)
            
            print("DOING STATIC == ", collectionViewCellWidth)
        } else{
            print("DOING NOT STATIC == ", widthForString(string: segmentTitles[selectedIndex] as! String))
            indicatorWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: widthForString(string: segmentTitles[selectedIndex] as! String))

            //indicatorView.widthAnchor.constraint(equalToConstant: widthForString(string: segmentTitles[selectedIndex] as! String)).isActive = true
        }
        indicatorWidthConstraint.isActive = true;

        super.updateConstraints()
    }
    
    
    
    
    /////
    
    
    //COLECUIOT VIEW STUFF
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentTitles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SegmentedHeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "segCell", for: indexPath) as! SegmentedHeaderCollectionViewCell
        cell.setTitle(title: segmentTitles[indexPath.row] as! String, font: buttonFont)
        
        if (selectedIndex == indexPath.row){
            cell.titleLabel.textColor = selectedColor
        } else{
            cell.titleLabel.textColor = deselectedColor
        }
        
        return cell;
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (staticCollectionViewWidth) {
            return CGSize(width: collectionViewCellWidth, height: viewHeight - 2)
        }
        let titleString: String = segmentTitles[indexPath.row] as! String
        
        return CGSize(width: widthForString(string: titleString), height: viewHeight-2)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if (!staticCollectionViewWidth) {
            return 16
        } else{
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if (!staticCollectionViewWidth) {
            return 16
        } else{
            return 0
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!hasScrolled) {
            hasScrolled = true;
            return;
        }
        if (scrollView == segmentCollectionView) {
            let cellFrame = frameForCellAtIndex(index: selectedIndex)
            if (cellFrame == CGRect.zero){
                return
            }
            let cellX = segmentCollectionView.convert(CGPoint(x: cellFrame.origin.x, y: cellFrame.origin.y), to: self).x
            indicatorLeadingConstraint.constant = cellX;
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection Selected = ", indexPath.row)
        if (selectedIndex != indexPath.row) {
            prepareToSelectIndex(nextIndex: indexPath.row)
        }
    }
    
    
    func prepareToSelectIndex(nextIndex: NSInteger){
        if (delegate?.segmentedHeaderShouldSelectSegement(atIndex: nextIndex, fromIndex: selectedIndex) == false){
            return
        }
        moveIndicatorView(toIndex: nextIndex)
        
        let lastIndex = selectedIndex
        selectedIndex = nextIndex
        
        UIView.setAnimationsEnabled(false)
        segmentCollectionView.reloadItems(at: [IndexPath(row: lastIndex, section: 0), IndexPath(row: selectedIndex, section: 0)])
        UIView.setAnimationsEnabled(true)
        self.delegate?.segmentedHeaderViewSelectedButtonAtIndex(index: nextIndex, title: segmentTitles[nextIndex] as! String)
    }
    
    func frameForCellAtIndex(index: NSInteger) -> CGRect{
        let cellAtIndex = segmentCollectionView.cellForItem(at: IndexPath(row: index, section: 0))
        if (cellAtIndex != nil){
            return cellAtIndex!.frame
        }
        return CGRect.zero
        //        return CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: 0, height: 0)

    }
    
    func checkCollectionViewCellWidth(){
        var totalWidth: CGFloat = minimumHorizontalPadding
        var widestString: CGFloat = 0
        
        for string in segmentTitles {
            totalWidth = totalWidth + minimumHorizontalPadding + widthForString(string: string as! String)
            if (widthForString(string: string as! String) > widestString){
                widestString = widthForString(string: string as! String)
            }
        }
        
        if (totalWidth > UIScreen.main.bounds.size.width - 16){
            staticCollectionViewWidth = false
            return
        }
        
        staticCollectionViewWidth = true
        
        let evenlyDistributedWidth = CGFloat((UIScreen.main.bounds.size.width - 16) / CGFloat(segmentTitles.count))
        
        if evenlyDistributedWidth > widestString {
            collectionViewCellWidth = evenlyDistributedWidth
            return
        }
        
        collectionViewCellWidth = widestString
    }
    
    func moveIndicatorView(toIndex: NSInteger){
        let toRect = frameForCellAtIndex(index: toIndex)
        indicatorWidthConstraint.constant = toRect.size.width

        let cellX = segmentCollectionView.convert(CGPoint(x: toRect.origin.x, y: toRect.origin.y), to: self).x
        indicatorLeadingConstraint.constant = cellX;
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    func widthForString(string: String) -> CGFloat{
        let attributes: [NSAttributedString.Key: Any] = [kCTFontAttributeName as NSAttributedString.Key: buttonFont]
        let attributedString = NSAttributedString.init(string: string, attributes: attributes)
        return attributedString.size().width
    }


}
