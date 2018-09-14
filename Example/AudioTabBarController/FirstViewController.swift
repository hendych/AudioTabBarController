//
//  FirstViewController.swift
//  AudioTabBarController
//
//  Created by Hendy Christianto on 09/13/2018.
//  Copyright (c) 2018 CocoaPods. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    init() {
        super.init(nibName: "FirstViewController", bundle: nil)
        
        loadViewIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func hideOrShowAudioTabButtonOnClick() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let isAudioBarShowing = appDelegate.tabBarController.isAudioTabBarShowing
        appDelegate.tabBarController.showAudioBar(!isAudioBarShowing, animated: true)
    }
    
    @IBAction func hideOrShowTabBarButtonOnClick() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let isTabBarShowing = appDelegate.tabBarController.isTabBarShowing
        appDelegate.tabBarController.showTabBar(!isTabBarShowing, animated: true)
    }
}

