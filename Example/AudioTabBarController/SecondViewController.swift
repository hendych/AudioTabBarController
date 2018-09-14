//
//  SecondViewController.swift
//  AudioTabBarController_Example
//
//  Created by Hendy Christianto on 14/09/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func goToDetail() {
        let detailVC = DetailViewController()
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
