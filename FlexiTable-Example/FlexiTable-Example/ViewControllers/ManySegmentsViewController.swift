//
//  ManySegmentsViewController.swift
//  FlexiTable
//
//  Created by Shayne Brady on 1/12/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit
import FlexiTable

class ManySegmentsViewController: FlexiTableViewController, SegmentedHeaderDelegate{
    
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
        let seg = SegmentedHeaderView.init(segmentTitles: ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6", "Option 7", "Option 8", "Option 9"], viewHeight: 50, horizontalPadding: 10)
        seg.delegate = self
        seg.buttonFont = UIFont(name: "KohinoorBangla-Semibold", size: 16)!
        self.segmentedHeaderView = seg
    }
    
    func setUpForegroundBackgroundViews(){
        let foregroundView = ParallaxHeaderView.init(title: "Parallax Header", font: UIFont.systemFont(ofSize: 22), textColor: UIColor.white, headerPosition: .bottom)
        
        foregroundView.headerLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24)!
        self.foregroundView = foregroundView
        
        let backgroundView = ParallaxBackgroundView.init(image: UIImage(named: "concert.jpeg")!)
        self.backgroundView = backgroundView
        self.setTableHeaderForegroundHeight(height: UIScreen.main.bounds.size.width * 0.6)
    }
    
    func segmentedHeaderViewSelectedButtonAtIndex(index: NSInteger, title: String) {
        switch index {
        case 0:
            tableview.dataSource = peopleTableAdapter
            tableview.delegate = peopleTableAdapter
        case 1:
            tableview.dataSource = bandsTableAdapter
            tableview.delegate = bandsTableAdapter
        default:
            tableview.dataSource = peopleTableAdapter
            tableview.delegate = peopleTableAdapter
        }
        tableview.reloadData()
    }
    
    func segmentedHeaderShouldSelectSegement(atIndex: NSInteger, fromIndex: NSInteger) -> Bool {
        if (atIndex == 4) {
            return false
        }
        return true
    }
}
