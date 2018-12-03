//
//  WithoutHeaderViewController.swift
//  FlexiTable
//
//  Created by Shayne Brady on 1/12/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit
import FlexiTable

class WithoutHeaderViewController: FlexiTableViewController, SegmentedHeaderDelegate{
    
    let peopleTableAdapter = PeopleTableAdapter()
    let bandsTableAdapter = BandsTableAdapter()
    
    override func viewDidLoad() {
        setUpSegmentedHeader()
        
        self.tableview.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        
        
        self.tableview.dataSource = peopleTableAdapter
        self.tableview.delegate = peopleTableAdapter
        
        super.viewDidLoad()
        
    }
    
    func setUpSegmentedHeader(){
        print("BOUT TO")
        let seg = SegmentedHeaderView.init(segmentTitles: ["No Sections", "Sections"], viewHeight: 200, horizontalPadding: 10)
        print("SEG == ", seg)
        
        seg.delegate = self
        seg.buttonFont = UIFont(name: "KohinoorBangla-Semibold", size: 16)!
        self.segmentedHeaderView = seg
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
