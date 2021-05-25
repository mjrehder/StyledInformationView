//
//  ViewController.swift
//  StyledInfoDemo
//
//  Created by Martin Rehder on 11.12.2016.
//  Copyright © 2016 Martin Jacob Rehder. All rights reserved.
//

import UIKit
import FlexMenu

class ViewController: UIViewController {

    @IBOutlet weak var infoView: StyledInformationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoView.headerText = NSAttributedString(string: "Information Header")

        let aIcon = UIImage(named: "plus_36pt")
        let ami = FlexMenuItem(title: "", titleShortcut: "", color: .clear, thumbColor: .clear, thumbIcon: aIcon)
        ami.selectionHandler = {
            NSLog("Plus selected")
        }
        let sIcon = UIImage(named: "search_36pt")
        let smi = FlexMenuItem(title: "", titleShortcut: "", color: .clear, thumbColor: .clear, thumbIcon: sIcon)
        smi.selectionHandler = {
            NSLog("Search selected")
        }
        
        self.infoView.menuItems = [ami, smi]
        self.infoView.menuAlignment = .center(maxWidth: 100)
        
        self.infoView.detailText = NSAttributedString(string: "This lower text area contains information you want to provide, such as a description of the actions the user can take.")
    }

}

