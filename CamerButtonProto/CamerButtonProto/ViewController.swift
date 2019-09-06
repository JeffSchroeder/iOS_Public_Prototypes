//
//  ViewController.swift
//  CamerButtonProto
//
//  Created by Jeff Schroeder on 8/30/19.
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
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraButton: CameraButton!
    @IBOutlet weak var videoButton: CameraButton!
    /// Style in the UI with the IBInspectable bits or use code like the following.
    //    {
    //    didSet {
    //        videoButton.isVideoButton = true
    //        videoButton.ringColor = .blue
    //        videoButton.centerColor = .black
    //        videoButton.ringWidth = 5
    //        videoButton.spacingWidth = 5
    //    }
    //}
    
    //override func viewDidLoad() {
    //    super.viewDidLoad()
    //}
    
    @IBAction func camerButtonTouchUpInside(_ sender: Any) {
        print("TouchUpInside")
        if let cameraButton = sender as? CameraButton {
            switch cameraButton.cameraButtonType {
            case .camera:
                showAlert(title: "Camera", message: "Do something take a photo like.")
            case .video:
                // NOTE: TouchUpInside is called by the component after the recording Bool is toggled.
                if cameraButton.recording {
                    showAlert(title: "Video Button", message: "Do something to START the recording now.")
                } else {
                    showAlert(title: "Video Button", message: "Do something to STOP the recording now.")
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        present(alert, animated: true)
    }
}
