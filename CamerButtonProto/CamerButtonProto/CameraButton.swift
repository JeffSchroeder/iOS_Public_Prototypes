//
//  CameraButton.swift
//
//  Created by Jeff Schroeder on 8/30/19 because it was needed.
//  Copyright © 2019 JeffSchroeder.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import Foundation
import UIKit

// NOTE: This sucker is designed as a square!!!
//
// Implementation with constraints
//      1) Aspect Ratio 1:1
//      2) Width or Height


/// Enum to differential between camera action or video action
public enum CameraButtonType: String {
    case camera, video
    
    var isVideo: Bool {
        switch self {
        case .camera:
            return false
        case .video:
            return true
        }
    }
}

@IBDesignable
/// The camera button is a button extension to mimic the actions of the VIDEO and CAMERA shutter control on the Camera app for iOS.  It is currently hooked up to the TouchUpInside event.
class CameraButton: UIButton {
    
    // MARK: - Member
    private var outlineCircleWidth = 3 as CGFloat
    private var spacing = 3 as CGFloat
    private var animationView = UIView()
    private var controlWidth = 0 as CGFloat
    private var circleWidth = 0 as CGFloat
    private var squareWidth = 0 as CGFloat
    private var currentlyAnimating = false
    /// Is the button in recording mode
    /// True:   When button is in the 'recording(center square)' style in video mode
    /// False:  When button is in camera mode or in the 'not recording(center circle)' style in video mode
    private(set) var recording = false
    /// Type of camera button this is
    private(set) var cameraButtonType = CameraButtonType.camera
    /// Gives a little vibration when the button is touched
    private var feedbackGenerator : UISelectionFeedbackGenerator? = nil
    
    // MARK: - IBInspectable members
    /// Is this a video button.
    /// Default Value: False
    @IBInspectable var isVideoButton: Bool {
        get {
            return cameraButtonType.isVideo
        }
        set {
            cameraButtonType = newValue ? .video : .camera
        }
    }
    
    /// Outter ring color
    /// Default Value: Red
    @IBInspectable var ringColor: UIColor = .red
    
    /// Outter ring width
    /// Default Value: 3
    @IBInspectable var ringWidth: Int {
        get {
            return Int(outlineCircleWidth)
        }
        set {
            outlineCircleWidth = CGFloat(newValue)
            setupAnimationViewCircle()
        }
    }
    
    /// Inner circle color
    /// Default Value: Red
    @IBInspectable var centerColor: UIColor = .red {
        didSet {
            animationView.backgroundColor = centerColor
            setupAnimationViewCircle()
        }
    }
    
    /// Spacing between outter ring and inner cirlce
    /// Default Value: 3
    @IBInspectable var spacingWidth: Int {
        get {
            return Int(spacing)
        }
        set {
            spacing = CGFloat(newValue)
            setupAnimationViewCircle()
        }
    }
    
    // MARK: - Page life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setTitle("", for:UIControl.State.normal)
    }
    
    override func prepareForInterfaceBuilder() {
        self.setTitle("", for:UIControl.State.normal)
        setupAnimationViewCircle()
    }
    
    override func draw(_ rect: CGRect) {
        let xY = outlineCircleWidth/2
        let width = controlWidth - outlineCircleWidth
        let outerRing = UIBezierPath(roundedRect: CGRect(x:xY, y:xY, width:width, height:width), cornerRadius: width/2)
        outerRing.lineWidth = outlineCircleWidth
        ringColor.setStroke()
        outerRing.stroke()
    }
}

// MARK: - Functions
extension CameraButton {
    /// Set up the control for initial use.
    private func setup() {
        self.setTitle("", for:UIControl.State.normal)
        setupAnimationViewCircle()
        animationView.isUserInteractionEnabled = false  // Let taps go to the control and not the view
        addTarget(self, action: #selector(self.touchUpInside), for: .touchUpInside)
        insertSubview(animationView, belowSubview: self.imageView!)
    }
    
    /// Sets up the animation view to a circle on the control. Camera or not recording state.
    private func setupAnimationViewCircle() {
        animationView.backgroundColor = centerColor
        controlWidth = frame.size.width
        circleWidth = controlWidth - (2 * outlineCircleWidth) - (2 * spacing)
        squareWidth = circleWidth * 2/3
        let xy = outlineCircleWidth + spacing
        animationView.frame = CGRect(x:xy , y:xy, width: circleWidth, height: circleWidth)
        animationView.layer.cornerRadius = circleWidth / 2
    }
    
    /// Sets up the animation view to a square for the video recording state
    private func setupAnimationViewSquare() {
        let calcXY = (Double(controlWidth) - Double(squareWidth))/2
        let castCalcXYFloat = NSNumber.init(value: calcXY).floatValue
        let xY = CGFloat(castCalcXYFloat)
        animationView.frame = CGRect(x:xY , y:xY , width: squareWidth, height: squareWidth)
        animationView.layer.cornerRadius = squareWidth/8
    }
    
    /// touchUpInside event Handler
    /// Use the 'recording' and 'cameraButtonType' to determine what action should be taken by the client
    @objc internal func touchUpInside() {
        print("cameraButton - controlTouched")
        if !currentlyAnimating {
            recording = !recording
            animateControl()
        }
    }
    
    /// Animation processing from one state to the next.
    private func animateControl() {
        feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator?.prepare()
        currentlyAnimating = true
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            if let cbt = self?.cameraButtonType {
                switch cbt {
                case .camera:
                    self?.animationView.alpha = 0
                case .video:
                    if let recording = self?.recording {
                        if recording {
                            self?.setupAnimationViewSquare()
                        } else {
                            self?.setupAnimationViewCircle()
                        }
                    }
                }
            }
            self?.feedbackGenerator?.selectionChanged()
        }) { [weak self] _ in
            if let cbt = self?.cameraButtonType {
                switch cbt {
                case .camera:
                    UIView.animate(withDuration: 0.25, animations: {  [weak self] in
                        self?.animationView.alpha = 1
                    }) { [weak self] _ in
                        self?.currentlyAnimating = false
                    }
                case .video:
                    self?.currentlyAnimating = false
                }
            } else {
                self?.currentlyAnimating = false
            }
        }
    }
}

