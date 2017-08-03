//
//  NORNavigationController.swift
//  nRF Toolbox
//
//  Created by Mostafa Berg on 27/04/16.
//  Copyright © 2016 Nordic Semiconductor. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.tintColor = UIColor.white
    }
}
