//
//  ViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let hatImageView: UIImageView = {
        let ov = UIImageView()
        ov.image = #imageLiteral(resourceName: "hat-1")
        return ov
    }()
    
    let descriptionLabel: UILabel = {
        let dsc = UILabel()
        dsc.backgroundColor = UIColor.white
        dsc.layer.cornerRadius = 20
        dsc.transform = CGAffineTransform(rotationAngle:  CGFloat(Double(2) * .pi/180))
        dsc.clipsToBounds = true
        dsc.text = " *Выберите количество игроков\n\n *Приступайте к обсуждению \n\n *У вас 5 минут \n\n *Найдите шпиона..."
        dsc.numberOfLines = 0
        dsc.font = UIFont(name: "Helvetica", size: 20)
        dsc.font = dsc.font.withSize(18)
        dsc.textColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        let offset = CGSize(width: 3.0, height: 2.0)
        dsc.layer.shadowOpacity = 100
        dsc.layer.shadowOffset =  offset
        dsc.layer.shadowRadius = 7.0
        return dsc
    }()
    
    let startButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Начать игру", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        setUpView()
        startButton.addTarget(self, action: #selector(tabStartButton), for: .touchUpInside)
    }
    
    @objc func tabStartButton(_ sender: UIButton) {
        let secondViewController = StartViewController()
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    func setUpView() {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "Find Spy Game"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        nameLabel.font = UIFont(name: "Helvetica", size: 20)
        nameLabel.font = nameLabel.font.withSize(32)
        nameLabel.transform = CGAffineTransform(rotationAngle:  CGFloat(Double(-3) * .pi/180))
        self.view.addSubview(hatImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(startButton)
        
        hatImageView.snp.makeConstraints {
            $0.height.equalTo(90)
            $0.width.equalTo(148)
            $0.top.equalToSuperview().offset(82)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(hatImageView.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(316)
            $0.top.equalTo(nameLabel.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(47)
            $0.centerX.equalToSuperview()
        }
    }
}

