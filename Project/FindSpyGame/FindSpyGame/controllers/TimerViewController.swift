//
//  TimerViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var fisishBtn: UIButton!
    @IBOutlet weak var finisgBtn: UIButton!
    var game: Game? = nil
    var timer: Timer? = nil
    var seconds = 360
    
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        fisishBtn.addTarget(self, action: #selector(didTapFinishBtn), for: .touchUpInside)
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(seconds > 0){
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }

    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @objc func didTapFinishBtn(_ sender: UIButton){
        timer?.invalidate()
        seconds = 360
        print("aaa")
        let alert = UIAlertController(title: "Game over", message: "Location is " + game!.location + " Spy number is " + String(game!.spyNumber), preferredStyle: UIAlertController.Style.alert)
        
        //        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        let okAction = UIAlertAction(title: "Start again", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            self.startMainViewController()
            
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func startMainViewController(){
        let mainViewController =
            self.storyboard!.instantiateViewController(withIdentifier: "MainViewController")
        self.present(mainViewController, animated: true, completion: nil)
    }
}
