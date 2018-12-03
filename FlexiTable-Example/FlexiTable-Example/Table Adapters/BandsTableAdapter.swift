//
//  BandsTableAdapter.swift
//  FlexiTable
//
//  Created by Shayne Brady on 1/12/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit
import FlexiTable

class BandsTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    let bands = ["Folk", "Metal", "Rap", "Country"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bands.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section * 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont(name: "KohinoorBangla-Regular", size: 14)
        cell?.textLabel?.textColor = UIColor.darkText
        cell!.textLabel?.text = String.init(format: "%@ Band %lu", bands[indexPath.section], indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as! SectionHeaderView
        header.headerLabel.text = bands[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let userInfo = ["offset":scrollView.contentOffset.y]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: FLEXI_TABLE_SCROLL_NOTIFICATION), object: nil, userInfo: userInfo)
    }
}
