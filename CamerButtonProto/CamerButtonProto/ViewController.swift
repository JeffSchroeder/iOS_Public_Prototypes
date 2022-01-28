//
//  ViewController.swift
//  CamerButtonProto
//
//  Created by Jeff Schroeder on 8/30/19.
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
