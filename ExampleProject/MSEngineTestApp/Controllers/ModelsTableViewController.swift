//
//  MenuViewController.swift
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 14/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//


import UIKit

class ModelsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PointLightTableViewCell") as? PointLightTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
