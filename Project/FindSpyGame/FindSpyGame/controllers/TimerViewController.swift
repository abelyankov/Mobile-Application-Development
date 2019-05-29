//
//  TimerViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TimerViewController: UIViewController {
    
    let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "У вас есть 5 минут, чтобы найти шпиона"
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica", size: 20)
        lbl.textColor = UIColor.white
        lbl.font = lbl.font.withSize(25)
        return lbl
    }()
    
    let timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica", size: 20)
        lbl.textColor = UIColor.white
        lbl.font = lbl.font.withSize(50)
        return lbl
    }()
    
    let finishButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Закончить игру", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    let menuBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Вернуться в меню", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    var timer: Timer? = nil
    var seconds = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        setupView()
        runTimer()
        finishButton.addTarget(self, action: #selector(didTapFinishBtn), for: .touchUpInside)
        menuBtn.addTarget(self, action: #selector(startMainViewController), for: .touchUpInside)
        menuBtn.isHidden = true
    }
    
    func setupView() {
        self.view.addSubview(infoLabel)
        self.view.addSubview(timerLabel)
        self.view.addSubview(finishButton)
        self.view.addSubview(menuBtn)
        
        infoLabel.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(316)
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        timerLabel.snp.makeConstraints {
            $0.height.equalTo(272)
            $0.width.equalTo(130)
            $0.top.equalTo(infoLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        finishButton.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(timerLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        menuBtn.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(timerLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
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
        let location = UserDefaults.standard.string(forKey: "location")
        let gameId = UserDefaults.standard.string(forKey: "gameId")
        let URL = "http://192.168.43.48:8080/finish_game/"
        Alamofire.request(URL, method: .get, parameters: ["gameId": gameId!])
            .responseJSON { response in
                print(response.request)
                print(response.response)
                print(response.result)
                if let value = response.result.value {
                    print("Did receive JSON data: \(value)")
                    if location! == "Spy" {
                        self.view.backgroundColor = .red
                    } else {
                        self.view.backgroundColor = .green
                    }
                }
                else {
                    print("JSON data is nil.")
                }
                self.finishButton.isHidden = true
                self.menuBtn.isHidden = false
        }
    }
    
 @objc func startMainViewController(_ sender: UIButton){
        let startViewController = MainViewController()
        self.present(startViewController, animated: true, completion: nil)
    }
}
