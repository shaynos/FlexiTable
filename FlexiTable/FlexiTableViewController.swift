//
//  FlexiTableViewController.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit

let ANIMATION_DURATION = 0.3;
public let FLEXI_TABLE_SCROLL_NOTIFICATION = "FLEXI_TABLE_SCROLL_NOTIFICATION"

class FlexiTableViewController: UIViewController, UITableViewDelegate{
    
    private var statusBarHeight: CGFloat = 0
    private var screenWidth: CGFloat = 0
    private var tableViewHeaderForegroundHeight: CGFloat = 0
    private var originalBackgroundHeight: CGFloat = 0
    private var originalBannerHeight: CGFloat = 0
    private var navBarHeight: CGFloat = 0

    private var previousNavBarHidden: Bool?
    
    private var
    bannerHeightConstraint,
    backgroundHeightConstraint,
    segmentedHeaderTopConstraint,
    searchContainerHeightConstraint,
    tableTopConstraint: NSLayoutConstraint?
    
    public var segmentedHeaderView: SegmentedHeaderView?
    public var foregroundView: FlexiTableForegroundBackgroundView?
    public var backgroundView: FlexiTableForegroundBackgroundView?
    public var tableview: UITableView
    public var backButton: UIButton?
    
    override func loadView() {
        self.view = UIView()
        if (self.view == nil){
            super.loadView()
        }
        
        let view = UIView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        self.view = view
        self.tableview = UITableView.init()
        
        screenWidth = UIScreen.main.bounds.size.width
        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        navBarHeight = 44
        previousNavBarHidden = self.navigationController?.isNavigationBarHidden
        
    }
    
    
    public init(backgroundView: FlexiTableForegroundBackgroundView, foregroundView: FlexiTableForegroundBackgroundView, segmentedHeaderView: SegmentedHeaderView){
        self.backgroundView = backgroundView
        self.foregroundView = foregroundView
        self.segmentedHeaderView = segmentedHeaderView
        
        self.tableview = UITableView()
        super.init(nibName: nil, bundle: nil)

    }
    
    public init(){
        self.tableview = UITableView()
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(scrollNotificationReceived(notification:)), name: NSNotification.Name(rawValue: FLEXI_TABLE_SCROLL_NOTIFICATION), object: nil)
        
        super.viewDidAppear(animated)
        
        print("Table VAtop == ", tableTopConstraint?.constant ?? "empty")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: FLEXI_TABLE_SCROLL_NOTIFICATION), object: nil)
        
        if (self.isMovingFromParent){
            self.navigationController?.setNavigationBarHidden(previousNavBarHidden!, animated:   true)
        }
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.setUpNavBar()
        
        if (self.isBeingPresented || self.isMovingToParent){
            if (backgroundView != nil){
                self.view.insertSubview(backgroundView!, at: 0)
                self.layoutBackgroundViewConstraints()
            }
            if (foregroundView != nil){
                self.view.addSubview(foregroundView!)
                self.layoutHeaderViewConstraints()
            }
            if (segmentedHeaderView != nil){
                self.view.addSubview(segmentedHeaderView!)
                self.layoutSegmentedHeaderViewConstraints()
            }
            
            self.view.insertSubview(tableview, at: 0)
            self.layoutTable()
            self.layoutBackButton()
            
            
            self.updateTableViewTopConstraintAnimated(animated: false)
        }
    }    

    @objc private func dismiss(_ sender:AnyObject?){
        self.navigationController?.setNavigationBarHidden(previousNavBarHidden!, animated: true)
        if (self != self.navigationController?.viewControllers[0]){
            print("popping")
            self.navigationController?.popViewController(animated: true)
        } else{
            print("dismissing")
            self.dismiss(animated: true, completion: nil)
        }
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpNavBar(){
        if ((backgroundView != nil) && self.navigationController?.isNavigationBarHidden != true) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if (backgroundView == nil && self.navigationController?.isNavigationBarHidden == true){
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
    private func layoutBackgroundViewConstraints(){
        backgroundView?.translatesAutoresizingMaskIntoConstraints = false
        backgroundView?.clipsToBounds = true
        
        backgroundHeightConstraint = NSLayoutConstraint(item: backgroundView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: tableViewHeaderForegroundHeight + statusBarHeight)
            
        backgroundHeightConstraint!.isActive = true
        
        originalBackgroundHeight = (backgroundHeightConstraint?.constant)!
        
        if #available(iOS 11.0, *) {
            backgroundView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -statusBarHeight).isActive = true
        } else{
            backgroundView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }
        
        backgroundView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        self.view.sendSubviewToBack(backgroundView!)
    }
    
    
    private func layoutHeaderViewConstraints(){
        foregroundView?.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            foregroundView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else{
            foregroundView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: statusBarHeight).isActive = true
        }
        
        foregroundView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        foregroundView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        foregroundView?.bottomAnchor.constraint(equalTo: (backgroundView?.bottomAnchor)!).isActive = true

    }
    
    
    private func layoutSegmentedHeaderViewConstraints(){
        segmentedHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        if ((backgroundView) != nil){
            // constrain the segmented header to the header view
            segmentedHeaderView?.topAnchor.constraint(equalTo: (backgroundView?.bottomAnchor)!).isActive = true
        } else{
            // constrain the segmented header to the top of the view
            segmentedHeaderTopConstraint = segmentedHeaderView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navBarHeight + statusBarHeight)
            segmentedHeaderTopConstraint?.isActive = true
        }
        
        segmentedHeaderView?.heightAnchor.constraint(equalToConstant: (segmentedHeaderView?.frame.size.height)!).isActive = true
        segmentedHeaderView?.leadingAnchor .constraint(equalTo: self.view.leadingAnchor).isActive = true
        segmentedHeaderView?.trailingAnchor .constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.view.bringSubviewToFront(segmentedHeaderView!)
    }
    
    private func layoutTable(){
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = UIColor.clear
        
        tableTopConstraint = NSLayoutConstraint(item: tableview, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: statusBarHeight + navBarHeight + segmentedHeaderView!.frame.size.height)
        tableTopConstraint?.isActive = true
        
        print("Table top == ", tableTopConstraint?.constant ?? "empty")
        print("statusBarHeight == ", statusBarHeight)
        print("navBarHeight == ", navBarHeight)
        print("segmentedHeaderView!.frame.size.height == ", segmentedHeaderView!.frame.size.height )
        print("Table top == ", tableTopConstraint?.constant ?? "empty")

        
        tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        self.updateTableHeader()
    }
    
    private func layoutBackButton(){
        if (foregroundView != nil){
            // no nav bar required as we have the header view. Add a navigation button to handle pop / dismiss
            backButton = UIButton.init()
            self.view.addSubview(backButton!)
            backButton?.translatesAutoresizingMaskIntoConstraints = false
            
            if #available(iOS 11.0, *) {
                backButton?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
            } else{
                backButton?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 7).isActive = true
            }
            
            backButton?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 2).isActive = true
            backButton?.widthAnchor.constraint(equalToConstant: 30).isActive = true
            backButton?.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            if (self == self.navigationController?.viewControllers[0]){
                backButton?.setBackgroundImage(UIImage.init(named: "whiteX.png"), for: .normal)
            } else{
                backButton?.setBackgroundImage(UIImage.init(named: "back_arrow.png"), for: .normal)
            }
            
            backButton?.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)


        } else{
            // add the back button to the nav bar if it is the root controller
            if (self == self.navigationController?.viewControllers[0]){
                let backBarButton = UIBarButtonItem(image: UIImage.init(named: "whiteX.png"), style: .plain, target: self, action: #selector(self.dismiss))
                self.navigationItem.leftBarButtonItem = backBarButton
            }
        }
    }
    
    
    // update layout
    
    private func updateTableViewTopConstraintAnimated(animated: Bool){
        let nextConstant = statusBarHeight + (segmentedHeaderView?.frame.size.height)! + navBarHeight
        tableTopConstraint?.constant = nextConstant
        
        if (animated){
            UIView.animate(withDuration: ANIMATION_DURATION) {
                self.view.layoutIfNeeded()
            }
        } else{
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateTableHeader(){
        var headerHeight: CGFloat = 0.0
        if (backgroundView != nil) {
            headerHeight = CGFloat(originalBackgroundHeight - navBarHeight - statusBarHeight)
        }
        let invisibleTableHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: headerHeight))
        invisibleTableHeader.backgroundColor = UIColor.clear
        invisibleTableHeader.isUserInteractionEnabled = false
        
        let tableOffset = tableview.contentOffset

        tableview.tableHeaderView = invisibleTableHeader
        
        tableview.contentOffset = tableOffset
        
    }
    
    private func tableviewDidScroll(offset: CGFloat){
        foregroundView?.flexiTableDidScroll(offset: offset)
        backgroundView?.flexiTableDidScroll(offset: offset)
        if (backgroundView != nil) {
            let newBackgroundHeight = originalBackgroundHeight - offset
            let minBackgroundHeight = navBarHeight + statusBarHeight
            
            if (newBackgroundHeight < minBackgroundHeight){
                // we dont want to shrink the header view to less than the nav bar height + status bar height
                backgroundHeightConstraint!.constant = minBackgroundHeight;
            } else{
                backgroundHeightConstraint!.constant = newBackgroundHeight;
            }
        } else{
            if (offset < 0){
                segmentedHeaderTopConstraint!.constant = 0 - (offset - navBarHeight - statusBarHeight);
            } else{
                segmentedHeaderTopConstraint!.constant = navBarHeight +  statusBarHeight;
            }
        }
    }
    
    @objc private func scrollNotificationReceived(notification: NSNotification){
        let dict: NSDictionary = notification.userInfo! as NSDictionary
        let offset: CGFloat = dict.value(forKey: "offset") as! CGFloat
        self.tableviewDidScroll(offset: offset)
    }
    
    public func setTableHeaderForegroundHeight(height: CGFloat){
        tableViewHeaderForegroundHeight = height;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == tableview) {
            tableviewDidScroll(offset: tableview.contentOffset.y)
        }
    }
}
