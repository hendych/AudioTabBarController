//
//  AudioPlaybackView.swift
//  AudioTabBarController_Example
//
//  Created by Hendy Christianto on 13/09/18.
//  Copyright © 2018 Hendy Christianto. All rights reserved.
//

import UIKit

class AudioPlaybackView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var audioTitle: UILabel!
    @IBOutlet weak var audioPublisher: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    func initialize() {
        Bundle.main.loadNibNamed("AudioPlaybackView", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        contentView.backgroundColor = .white
    }
}
