//
//  ViewController.swift
//  LongPress
//
//  Created by Jeff Schroeder on 12/16/19.
//  Copyright © 2019 Jeffrey Schroeder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var theTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.processLongPress))
        longPress.minimumPressDuration = TimeInterval(0.5)
        if let recognizers = view.gestureRecognizers {
            for recognizer in recognizers {
                longPress.require(toFail: recognizer)
            }
        }
        view.addGestureRecognizer(longPress)
    }
    
    @objc func processLongPress(gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .possible:
            print("began")
            theTimer = nil
        case .began:
            print("began")
            theTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(processSomething), userInfo: nil, repeats: false)
        case .changed:
            print("changed")
            theTimer = nil
        case .ended:
            print("ended")
            guard let _ = theTimer else { return }
            processSomething()
        case .cancelled:
            print("cancelled")
            theTimer = nil
        case .failed:
            print("failed")
            theTimer = nil
        @unknown default:()
            
        }
    }
    
    @objc func processSomething() {
        if self.theTimer != nil {
            print("processSomething")
            self.theTimer = nil
        }
    }
}

