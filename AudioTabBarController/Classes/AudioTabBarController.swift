//
//  AudioTabBarController.swift
//  Hendy
//
//  Created by Hendy Christianto on 12/09/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit


fileprivate struct Constants {
    static let DefaultTabBarHeight: CGFloat = 49
    static let AnimationDuration: TimeInterval = 0.3
    static let ZPositionTabBar: CGFloat = 150
    static let RadiusShadow: CGFloat = 2
    static let AnimationDamping: CGFloat = 0.7
    static let AnimationSpringVelocity: CGFloat = 0.25
    static let DefaultShadowColor = UIColor(white: 179.0 / 255.0, alpha: 1)
}


public protocol AudioTabBarControllerDelegate: class {
    func audioTabBarController(_ audioTabBarController: AudioTabBarController, didSelect: UIViewController)
}


open class AudioTabBarController: UIViewController {
    open weak var delegate: AudioTabBarControllerDelegate?
    
    public var selectedIndex = 0 {
        didSet {
            setMainViewControllerView(viewControllers[selectedIndex])
        }
    }
    
    @IBOutlet private(set) public weak var contentView: UIView!
    @IBOutlet private(set) public weak var tabBar: UITabBar!
    @IBOutlet private(set) public weak var audioTabBar: UIView!
    
    @IBOutlet weak var tabBarBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var audioTabBarHeight: NSLayoutConstraint!
    @IBOutlet weak var audioTabBottomMargin: NSLayoutConstraint!
    
    private(set) public var isAudioTabBarShowing = false
    private(set) public var isTabBarShowing = true
    private(set) public var viewControllers = [UIViewController]()
    private(set) public weak var selectedViewController: UIViewController? {
        didSet {
            guard let selectedVC = selectedViewController else { return }
            
            delegate?.audioTabBarController(self, didSelect: selectedVC)
        }
    }
    
    private let contentViewController = UIViewController()
    private var isAnimating = false
    
    
    public init() {
        let podBundle = Utils.loadBundle(for: AudioTabBarController.self)
        
        super.init(nibName: "AudioTabBarController", bundle: podBundle)
        
        loadViewIfNeeded()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Setup
    func configureUI() {
        // Configure content view controller
        addChildViewController(contentViewController)
        
        contentViewController.view.frame = contentView.bounds
        
        contentView.insertSubview(contentViewController.view, at: 0)
        
        contentViewController.didMove(toParentViewController: self)
        
        // Audio Tab Bar
        let shadowPath = UIBezierPath(rect: audioTabBar.bounds)
        audioTabBar.layer.masksToBounds = false
        audioTabBar.layer.shadowColor = Constants.DefaultShadowColor.cgColor
        audioTabBar.layer.shadowOffset = .zero
        audioTabBar.layer.shadowOpacity = 1
        audioTabBar.layer.shadowPath = shadowPath.cgPath
        audioTabBar.layer.shadowRadius = Constants.RadiusShadow
        
        // Reorder zPosition for tab bar
        audioTabBar.layer.zPosition = Constants.ZPositionTabBar - 1
        tabBar.layer.zPosition = Constants.ZPositionTabBar
    }
    
    
    // MARK: - Public Methods
    
    /// Set view controller stack within UITabBar.
    /// Will create UITabBarItem based on the corresponding tabBarItem assigned on the UIViewController.
    ///
    /// - Parameter viewControllers: array of UIViewControllers.
    open func setViewController(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        // Adding tab items
        var tabItems = [UITabBarItem]()
        var index = 0
        for viewController in viewControllers {
            var tabItem: UITabBarItem = viewController.tabBarItem
            
            if Utils.isEmptyTabBarItem(tabBar: tabItem) {
                tabItem = UITabBarItem(title: "View \(index + 1)", image: nil, tag: index)
            }
            
            tabItems.append(tabItem)
            
            index = index + 1
        }
        
        tabBar.setItems(tabItems, animated: false)
        
        // Add first view controller to screen
        selectedIndex = 0
    }
    
    
    /// Show the audio tab bar.
    ///
    /// - Parameters:
    ///   - isShowing: flag that indicates to show or hide.
    ///   - animated: flat that indicates to animate or not.
    open func showAudioBar(_ isShowing: Bool, animated: Bool) {
        if isAnimating { return }
        
        isAnimating = true

        if isShowing {
            audioTabBar.isHidden = false
            audioTabBottomMargin.constant = 0
        } else {
            audioTabBottomMargin.constant = -audioTabBar.frame.size.height
        }
        
        var animationDuration = Constants.AnimationDuration
        if animated == false {
            animationDuration = 0
        }
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: Constants.AnimationDamping,
                       initialSpringVelocity: Constants.AnimationSpringVelocity,
                       options: .curveEaseInOut,
                       animations: {
                        
                        if isShowing {
                            self.audioTabBar.alpha = 1
                        } else {
                            self.audioTabBar.alpha = 0
                        }
                        
                        self.view.layoutIfNeeded()
        }) { (completed) in
            self.isAudioTabBarShowing = isShowing
            self.audioTabBar.isHidden = !isShowing
            self.isAnimating = false
        }
    }
    
    
    /// Show the UITabBar
    ///
    /// - Parameters:
    ///   - isShowing: flag that indicates to show or hide.
    ///   - animated: flat that indicates to animate or not.
    open func showTabBar(_ isShowing: Bool, animated: Bool) {
        if isAnimating { return }
        
        isAnimating = true
        
        if isShowing {
            tabBar.isHidden = false
            tabBarBottomMargin.constant = 0
        } else {
            tabBarBottomMargin.constant = -Constants.DefaultTabBarHeight
        }
        
        var animationDuration = Constants.AnimationDuration
        if animated == false {
            animationDuration = 0
        }
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: Constants.AnimationDamping,
                       initialSpringVelocity: Constants.AnimationSpringVelocity,
                       options: .curveEaseInOut,
                       animations: {
                        
                        if isShowing {
                            self.tabBar.alpha = 1
                        } else {
                            self.tabBar.alpha = 0
                        }
                        
                        self.view.layoutIfNeeded()
        }) { (completed) in
            self.isTabBarShowing = isShowing
            self.tabBar.isHidden = !isShowing
            self.isAnimating = false
        }
    }
    
    
    /// Add audio player playback view to the audio tab bar.
    /// The subview will be fit to the audio tab bar bounds.
    ///
    /// - Parameter view: UIView
    public func addAudioPlaybackView(_ view: UIView) {
        view.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        view.frame = audioTabBar.bounds
        
        audioTabBar.addSubview(view)
        audioTabBar.backgroundColor = view.backgroundColor
    }
    
    
    /// Set audio tab bar height
    ///
    /// - Parameter height: desired height.
    public func setAudioBarHeight(_ height: CGFloat) {
        audioTabBarHeight.constant = height
        
        view.setNeedsUpdateConstraints()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    
    // MARK: - Private Methods
    
    /// Set main view content to selected view controller from viewControllers stack.
    /// Will remove previous selected view controller from parent if any.
    ///
    /// - Parameter viewController: selected view controller that want to be shown.
    fileprivate func setMainViewControllerView(_ viewController: UIViewController) {
        if let previousViewController = selectedViewController {
            previousViewController.willMove(toParentViewController: nil)
            previousViewController.view.removeFromSuperview()
            previousViewController.removeFromParentViewController()
        }
        
        viewController.loadViewIfNeeded()
        viewController.view.frame = contentViewController.view.bounds
        viewController.view.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        
        contentViewController.addChildViewController(viewController)
        contentViewController.view.addSubview(viewController.view)
        
        viewController.didMove(toParentViewController: contentViewController)
        
        
        if let indexViewController = viewControllers.index(of: viewController) {
            tabBar.selectedItem = tabBar.items?[indexViewController]
        }
        
        selectedViewController = viewController
    }
}


// MARK: - UITabBar Delegate
extension AudioTabBarController: UITabBarDelegate {
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabItemIndex = tabBar.items?.index(of: item) else { return }
        
        selectedIndex = tabItemIndex
    }
}
