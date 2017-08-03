//
//  NORMainViewController.swift
//  nRF Toolbox
//
//  Created by Mostafa Berg on 27/04/16.
//  Copyright © 2016 Nordic Semiconductor. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIAlertViewDelegate {

    @IBAction func aboutButtonTapped(_ sender: AnyObject) {
        showAboutAlertView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showAboutAlertView() {
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let aboutMessage = String("TODO.\n\nVersion \(appVersion)")
        let alertView = UIAlertView.init(title: "About", message: aboutMessage!, delegate: self, cancelButtonTitle: "Ok", otherButtonTitles:"GitHub")
        alertView.show()
    }

    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            UIApplication.shared.openURL(URL(string: "https:TODO")!)
        }
    }
    
}
