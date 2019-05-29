//
//  ViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit
import SnapKit
import AccountKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, AKFViewControllerDelegate {
    
     var accountKit: AccountKit!
    
    let nameLabel:  UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "Find Spy Game"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        nameLabel.font = UIFont(name: "Helvetica", size: 20)
        nameLabel.font = nameLabel.font.withSize(32)
        nameLabel.transform = CGAffineTransform(rotationAngle:  CGFloat(Double(-3) * .pi/180))
        return nameLabel
    }()

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
        btn.setTitle("Авторизоваться", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    let enterBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Начать игру", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    let logoutBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Выйти", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        setUpView()
        enterBtn.isHidden = true
        logoutBtn.isHidden = true
        startButton.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        enterBtn.addTarget(self, action: #selector(enterBtnPressed), for: .touchUpInside)
        logoutBtn.addTarget(self, action: #selector(logoutBtnPressed), for: .touchUpInside)
        if accountKit == nil {
            self.accountKit = AccountKit(responseType: .accessToken)
        }
    }
    
    @objc func enterBtnPressed(_ sender: UIButton) {
        print("YA TAPNUL")
        accountKit.requestAccount {
            (account, error) -> Void in
            let phoneNumber = account?.phoneNumber!.stringRepresentation()
            let URL = "http://192.168.43.48:8080/create_person/"
            Alamofire.request(URL, method: .get, parameters: ["phoneNumber": phoneNumber!])
                .responseJSON { response in
                    print("REEEQUEST")
                    print(response.request!)
                    print(response.response!)
                    print(response.result)
                    if let value = response.result.value {
                        print("Did receive JSON data: \(value)")
                        let user_id = JSON(value)["id"].intValue
                        UserDefaults.standard.set(user_id, forKey: "user_id")
                        let user = UserDefaults.standard.string(forKey: "user_id")
                        print("AAAA USEEEER")
                        print(user!)
                        let secondViewController = MainViewController()
                        self.present(secondViewController, animated: true, completion: nil)
                    }
                    else {
                        print("JSON data is nil.")
                    }
                    
            }
        }
        

    }

    func setUpView() {
        
        self.view.addSubview(hatImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(startButton)
        self.view.addSubview(enterBtn)

        hatImageView.snp.makeConstraints {
            $0.height.equalTo(90)
            $0.width.equalTo(148)
            $0.top.equalToSuperview().offset(22)
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
        
        enterBtn.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(47)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(enterBtn.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    func prepareLoginViewController(_ loginViewController: AKFViewController) {
        loginViewController.delegate = self
        loginViewController.defaultCountryCode = "KZ"
        
        let theme = Theme.default()
        theme.statusBarStyle = .lightContent
        theme.inputTextColor = .white
        theme.textColor = .white
        theme.headerBackgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        theme.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        theme.headerTextColor = .white
        theme.iconColor = .white
        theme.inputBorderColor = .white
        theme.inputBackgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        theme.buttonBorderColor = .white
        theme.buttonBackgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        theme.buttonTextColor = .white
        theme.titleColor = .white
        
        loginViewController.setTheme(theme)
    }
    
    @objc func loginBtnPressed() {
        print("pressed")
        let inputState = UUID().uuidString
        print(inputState)
        let viewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as AKFViewController
        viewController.isSendToFacebookEnabled = true
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
    }
    
    @objc func logoutBtnPressed() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        print("tapped")
        let accessTokenValue = UserDefaults.standard.string(forKey: "accessToken")
        print("Lol go back to main")
        let viewController = ViewController()
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    func viewController(_ viewController: (UIViewController & AKFViewController), didCompleteLoginWith accessToken: AccessToken, state: String) {
        UserDefaults.standard.set(accessToken.tokenString, forKey: "accessToken")
        guard let accessTokenValue = UserDefaults.standard.string(forKey: "accessToken") else {return}
        print(accessTokenValue)
        startButton.isHidden = true
        enterBtn.isHidden = false
        logoutBtn.isHidden = false
    }
}
