//
//  LocationViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var showLocationBtn: UIButton!
    @IBOutlet weak var nextPlayerBtn: UIButton!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var game: Game? = nil
    
    var currentPlayerNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(game!)
        playerNumberLabel.text = "Player #1"
        showShowLocationBtn()
        dismissLocationLayout()
    }
    
    
    func showShowLocationBtn(){
        showLocationBtn.isHidden = false
        showLocationBtn.addTarget(self,action: #selector(showLocation), for: .touchUpInside)
    }
    
    func dismissShowLocationBtn(){
        showLocationBtn.isHidden = true
        showLocationBtn.isEnabled = false
    }
    
    @objc func showLocation(_ sender: UIButton){
        showLocationBtn.isHidden = true
        nextPlayerBtn.isHidden = false
        nextPlayerBtn.isEnabled = true
        locationLabel.isHidden = false
        
        if(currentPlayerNumber != game?.totalNumberOfPlayers){
            if(currentPlayerNumber != game?.spyNumber){
                locationLabel.text = game?.location
            }
            else{
                locationLabel.text = "You are a spy"
            }
            nextPlayerBtn.addTarget(self, action: #selector(showNextPlayer), for: .touchUpInside)
        }
        else{
            nextPlayerBtn.setTitle("start time", for: .normal)
            nextPlayerBtn.addTarget(self,action:  #selector(startTimerController), for: .touchUpInside)
        }
    }
    
    
    func dismissLocationLayout(){
        nextPlayerBtn.isHidden = true
        nextPlayerBtn.isEnabled = false
        locationLabel.isHidden = true
    }
    
    @objc func showNextPlayer(_ sender: UIButton){
        dismissLocationLayout()
        currentPlayerNumber += 1
        playerNumberLabel.text = "Player #" + String(currentPlayerNumber)
        showShowLocationBtn()
    }
    
    @objc func startTimerController(_ sender: UIButton){
        let timerViewController =
            storyboard?.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        timerViewController.game = game
        self.present(timerViewController, animated: true, completion: nil)
    }
}
