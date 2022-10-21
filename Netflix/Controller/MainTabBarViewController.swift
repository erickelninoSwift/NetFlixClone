//
//  ViewController.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        CustomNavigationTab(ViewControllerTab: self, viewcontroller1: HomeViewController(), viewcontroller2: UpComingViewController(), viewcontroller3: SearchViewController(), viewcontroller4: DownloadViewController())
    }
}

