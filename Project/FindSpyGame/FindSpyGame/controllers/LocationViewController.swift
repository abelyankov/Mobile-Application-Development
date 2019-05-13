//
//  LocationViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Нажмите на кнопку, чтобы узнать локацию"
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica", size: 20)
        lbl.textColor = UIColor.white
        lbl.font = lbl.font.withSize(25)
        return lbl
    }()
    
    let playerNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Игрок #1"
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica", size: 20)
        lbl.textColor = UIColor.white
        lbl.font = lbl.font.withSize(25)
        return lbl
    }()
    
    let locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica", size: 20)
        lbl.textColor = UIColor.white
        lbl.font = lbl.font.withSize(30)
        return lbl
    }()
    
    let showLocationButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Узнать локацию", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    let nextPlayerButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Следующий игрок", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    var game: Game? = nil
    
    var currentPlayerNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(game!)
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        setupView()
        showLocationButton.addTarget(self,action: #selector(showLocation), for: .touchUpInside)
        dismissLocationLayout()
    }
    
    func setupView() {
        
        self.view.addSubview(infoLabel)
        self.view.addSubview(playerNumberLabel)
        self.view.addSubview(showLocationButton)
        self.view.addSubview(nextPlayerButton)
        self.view.addSubview(locationLabel)
        
        infoLabel.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(316)
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        playerNumberLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.top.equalTo(playerNumberLabel.snp.bottom).offset(10)
        }
        
        showLocationButton.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(playerNumberLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
        
        nextPlayerButton.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(playerNumberLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func showShowLocationBtn(){
        showLocationButton.isHidden = false
    }

    func dismissShowLocationBtn(){
        showLocationButton.isHidden = true
        showLocationButton.isEnabled = false
    }

    @objc func showLocation(_ sender: UIButton){
        showLocationButton.isHidden = true
        nextPlayerButton.isHidden = false
        nextPlayerButton.isEnabled = true
        locationLabel.isHidden = false

        if(currentPlayerNumber != game?.totalNumberOfPlayers){
            if(currentPlayerNumber != game?.spyNumber){
                locationLabel.text = game?.location
            }
            else{
                locationLabel.text = "Вы шпион 🤫"
            }
            nextPlayerButton.addTarget(self, action: #selector(showNextPlayer), for: .touchUpInside)
        }
        else{
            nextPlayerButton.setTitle("Запустить таймер ⏱", for: .normal)
            nextPlayerButton.addTarget(self,action:  #selector(startTimerController), for: .touchUpInside)
        }
    }

    func dismissLocationLayout(){
        nextPlayerButton.isHidden = true
        nextPlayerButton.isEnabled = false
        locationLabel.isHidden = true
    }

    @objc func showNextPlayer(_ sender: UIButton){
        dismissLocationLayout()
        currentPlayerNumber += 1
        playerNumberLabel.text = "Игрок #" + String(currentPlayerNumber)
        showShowLocationBtn()
    }

    @objc func startTimerController(_ sender: UIButton){
        let timerViewController = TimerViewController()
        timerViewController.game = game
        self.present(timerViewController, animated: true, completion: nil)
    }
}
