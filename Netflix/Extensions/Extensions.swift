//
//  Extensions.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/10.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit


extension String
{
    func capitalizedFirstLeter() -> String
    {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}


extension UIViewController
{
    
    
    func configureUIBackground()
    {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground // your colour here
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func CustomNavigationTab(ViewControllerTab: UITabBarController ,viewcontroller1: UIViewController,viewcontroller2: UIViewController,viewcontroller3: UIViewController,viewcontroller4: UIViewController)
     {
         let destinationVC1 = UINavigationController(rootViewController: viewcontroller1)
         let destinationVC2 = UINavigationController(rootViewController: viewcontroller2)
         let destinationVC3 = UINavigationController(rootViewController: viewcontroller3)
         let destinationVC4 = UINavigationController(rootViewController: viewcontroller4)
         

         destinationVC1.tabBarItem.image = UIImage(systemName: "house")
         destinationVC2.tabBarItem.image = UIImage(systemName: "play.circle")
         destinationVC3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
         destinationVC4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
         
     
         destinationVC1.title = "Home"
         destinationVC2.title = "Coming Soon"
         destinationVC3.title = "Top Search"
         destinationVC4.title = "Downloads"
         
        ViewControllerTab.tabBar.tintColor = .label
        ViewControllerTab.setViewControllers([destinationVC1,destinationVC2,destinationVC3,destinationVC4], animated: true)
     }
    
    func viewControllerHeaderTitle(mytitle: String)
    {
        self.title = mytitle

        
          navigationController?.navigationBar.prefersLargeTitles = true
          navigationController?.navigationItem.largeTitleDisplayMode = .always
          navigationController?.navigationBar.barTintColor = .systemBackground
    }
}
