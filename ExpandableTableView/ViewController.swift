//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by Morteza on 7/2/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var headers = [1, 0, 0, 1] //  Array of header, 1 means expanded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }


}

extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.headers[section] == 0) ? 0 : 5
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        viewHeader.backgroundColor = UIColor.darkGray // Changing the header background color to gray
        let arrow = UILabel(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        arrow.text = (self.headers[section] == 0) ? "⬇︎" : "⬆︎"
        arrow.textColor = .white
        arrow.font = UIFont.boldSystemFont(ofSize: 20)
        viewHeader.addSubview(arrow)
        let button = UIButton(type: .custom)
        button.frame = viewHeader.bounds
        button.tag = section // Assign section tag to this button
        button.addTarget(self, action: #selector(tapSection(sender:)), for: .touchUpInside)
        button.setTitle("Section: \(section)", for: .normal)
        viewHeader.addSubview(button)
        return viewHeader
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "section: \(indexPath.section)  row: \(indexPath.row)"
        return cell
    }

    
    @objc func tapSection(sender: UIButton) {
        self.headers[sender.tag] = (self.headers[sender.tag] == 0) ? 1 : 0
        self.tableView.reloadSections([sender.tag], with: .fade)
        
    }
}
