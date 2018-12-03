//
//  ProfileViewController.swift
//  FlexiTable
//
//  Created by Shayne Brady on 1/12/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit
import FlexiTable

class ProfileViewController: FlexiTableViewController, SegmentedHeaderDelegate{
    
    let peopleTableAdapter = PeopleTableAdapter()
    let bandsTableAdapter = BandsTableAdapter()
    
    override func viewDidLoad() {
        setUpSegmentedHeader()
        setUpForegroundBackgroundViews()
        
        self.tableview.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        
        self.backImage = UIImage(named: "back_image.png")
        self.closeImage = UIImage(named: "close_image.png")

        self.tableview.dataSource = peopleTableAdapter
        self.tableview.delegate = peopleTableAdapter
        
        super.viewDidLoad()
        
    }
    
    func setUpSegmentedHeader(){
        let seg = SegmentedHeaderView.init(segmentTitles: ["No Sections", "Sections"], viewHeight: 50, horizontalPadding: 20)
        seg.delegate = self
        seg.buttonFont = UIFont(name: "KohinoorBangla-Semibold", size: 16)!
        self.segmentedHeaderView = seg
    }
    
    func setUpForegroundBackgroundViews(){
        let foregroundView = ProfileHeaderView(maxImageHeight: 100, image: UIImage(named: "person.jpeg")!, title: "John", subtitle: "John is awesome")
        foregroundView.titleLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24)!
        foregroundView.subtitleLabel.font = UIFont(name: "KohinoorBangla-Light", size: 18)!
        
        foregroundView.titleLabel.textColor = UIColor.white
        foregroundView.subtitleLabel.textColor = UIColor.white
        
        self.foregroundView = foregroundView
        
        let backgroundView = ParallaxBackgroundView.init(image: UIImage(named: "concert.jpeg")!)
        self.backgroundView = backgroundView
        self.setTableHeaderForegroundHeight(height: 120)
    }
    
    func segmentedHeaderViewSelectedButtonAtIndex(index: NSInteger, title: String) {
        print("SEG SELECTED == ", index)
        switch index {
        case 0:
            tableview.dataSource = peopleTableAdapter
            tableview.delegate = peopleTableAdapter
        case 1:
            tableview.dataSource = bandsTableAdapter
            tableview.delegate = bandsTableAdapter
        case 2:
            tableview.dataSource = peopleTableAdapter
            tableview.delegate = peopleTableAdapter
        case 3:
            tableview.dataSource = peopleTableAdapter
            tableview.delegate = peopleTableAdapter
            
        default:
            tableview.dataSource = peopleTableAdapter
            tableview.delegate = peopleTableAdapter
        }
        tableview.reloadData()
    }
    
    func segmentedHeaderShouldSelectSegement(atIndex: NSInteger, fromIndex: NSInteger) -> Bool {
        return true
    }
    
}
