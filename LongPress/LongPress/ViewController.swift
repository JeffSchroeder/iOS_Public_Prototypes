//
//  ViewController.swift
//  LongPress
//
//  Created by Jeff Schroeder on 12/16/19.
//

import UIKit

class ViewController: UIViewController {
    
    var theTimer: Timer?
    var whatsHappening = [String]()
    
    @IBOutlet weak var whatsHappeningTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        whatsHappening.append("Form Loaded")
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
        print("\(whatsHappening.startIndex)")
        switch gesture.state {
            
        case .possible:
            //whatsHappening.append("possible")
            whatsHappening.insert("possible", at: whatsHappening.startIndex + 1)
            print("possible")
            theTimer = nil
        case .began:
            //whatsHappening.append("began")
            whatsHappening.insert("began", at: whatsHappening.startIndex)
            print("began")
            theTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(processSomething), userInfo: nil, repeats: false)
        case .changed:
            whatsHappening.insert("theTimer", at: whatsHappening.startIndex)
            print("changed")
            theTimer = nil
        case .ended:
            guard let _ = theTimer else {
                whatsHappening.insert("ended - already processed", at: whatsHappening.startIndex)
                print("ended - already processed")
                whatsHappeningTableView.reloadData()
                return
            }
            whatsHappening.insert("ended", at: whatsHappening.startIndex)
            print("ended")
            processSomething()
        case .cancelled:
            whatsHappening.insert("cancelled", at: whatsHappening.startIndex)
            print("cancelled")
            theTimer = nil
        case .failed:
            whatsHappening.insert("failed", at: whatsHappening.startIndex)
            print("failed")
            theTimer = nil
        @unknown default:()
        }
        whatsHappeningTableView.reloadData()
    }
    
    @objc func processSomething() {
        if self.theTimer != nil {
            whatsHappening.insert("processSomething", at: whatsHappening.startIndex)
            print("processSomething")
            self.theTimer = nil
            whatsHappeningTableView.reloadData()
        }
    }
}
extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whatsHappening.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhatsHappeningCell", for: indexPath)
        
        cell.textLabel?.text = whatsHappening[indexPath.row]
        return cell
    }
}
