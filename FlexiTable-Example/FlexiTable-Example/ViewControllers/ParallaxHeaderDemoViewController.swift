//
//  ParallaxHeaderDemoViewController.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit
import FlexiTable

class ParallaxHeaderDemoViewController: FlexiTableViewController, SegmentedHeaderDelegate{
    
    let peopleTableAdapter = PeopleTableAdapter()
    let bandsTableAdapter = BandsTableAdapter()
    
    override func viewDidLoad() {
        setUpSegmentedHeader()
        setUpForegroundBackgroundViews()
        self.tableview.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        self.tableview.dataSource = peopleTableAdapter
        self.tableview.delegate = peopleTableAdapter
        
        self.backImage = UIImage(named: "back_image.png")
        self.closeImage = UIImage(named: "close_image.png")
        
        super.viewDidLoad()
    }
    
    func setUpSegmentedHeader(){
        let seg = SegmentedHeaderView.init(segmentTitles: ["Option 1", "Option 2", "Option 3", "Option 4"], viewHeight: 50, horizontalPadding: 20)
        seg.delegate = self
        seg.buttonFont = UIFont(name: "KohinoorBangla-Semibold", size: 16)!
        seg.selectedColor = UIColor.blue
        seg.deselectedColor = UIColor.lightGray
        self.segmentedHeaderView = seg
    }
    
    func setUpForegroundBackgroundViews(){
        let foregroundView = ParallaxHeaderView.init(title: "Parallax Header", font: UIFont.systemFont(ofSize: 22), textColor: UIColor.white, headerPosition: .center)
        foregroundView.headerLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24)!
        self.foregroundView = foregroundView
        
        let backgroundView = ParallaxBackgroundView.init(image: UIImage(named: "concert.jpeg")!)
        self.backgroundView = backgroundView
        self.setTableHeaderForegroundHeight(height: UIScreen.main.bounds.size.width * 0.6)
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
