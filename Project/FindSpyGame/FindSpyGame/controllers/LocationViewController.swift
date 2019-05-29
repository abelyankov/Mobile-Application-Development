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
        lbl.text = "Ваша локация"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        setupView()
        showLocationButton.addTarget(self,action: #selector(showLocation), for: .touchUpInside)
        locationLabel.isHidden = true
    }
    
    func setupView() {
        
        self.view.addSubview(infoLabel)
        self.view.addSubview(showLocationButton)
        self.view.addSubview(locationLabel)
        
        infoLabel.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(316)
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
        }
        
        showLocationButton.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(locationLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
    
        
    }

    @objc func showLocation(_ sender: UIButton){
        locationLabel.isHidden = false
        let location = UserDefaults.standard.string(forKey: "location")
        locationLabel.text = location!
        showLocationButton.setTitle("Запустить таймер", for: .normal)
        showLocationButton.addTarget(self,action: #selector(startTimerController), for: .touchUpInside)
    }
    
    @objc func startTimerController(_ sender: UIButton){
        let timerViewController = TimerViewController()
        self.present(timerViewController, animated: true, completion: nil)
    }
}
