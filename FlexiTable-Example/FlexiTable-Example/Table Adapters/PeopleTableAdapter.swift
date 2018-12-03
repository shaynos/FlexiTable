//
//  PeopleTableAdapter.swift
//  FlexiTable
//
//  Created by Shayne Brady on 1/12/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit
import FlexiTable

class PeopleTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    let people = ["John D.", "Alex J.", "Sally K.", "Molly P.", "Trevor L.", "Brian D.", "Peter L.", "Larry Y.", "Cyndy D.", "Kerry P."]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont(name: "KohinoorBangla-Regular", size: 14)
        cell?.textLabel?.textColor = UIColor.darkText
        cell!.textLabel?.text = people[indexPath.row]
        return cell!
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let userInfo = ["offset":scrollView.contentOffset.y]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: FLEXI_TABLE_SCROLL_NOTIFICATION), object: nil, userInfo: userInfo)
    }
}
