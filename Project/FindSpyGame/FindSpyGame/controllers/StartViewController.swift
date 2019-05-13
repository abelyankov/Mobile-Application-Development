//
//  StartViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/13/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Для начала игры введите количество игроков"
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica", size: 20)
        lbl.textColor = UIColor.white
        lbl.font = lbl.font.withSize(25)
        return lbl
    }()
    
    let numberOfPlayersTextField: UITextField = {
        let txtField = UITextField()
        txtField.layer.cornerRadius = 20
        txtField.backgroundColor = UIColor.white
        txtField.keyboardType = UIKeyboardType.phonePad
        txtField.leftView = UIView(frame: CGRect(x: 4, y: 0, width: 15, height: txtField.frame.height))
        txtField.leftViewMode = .always
        txtField.keyboardType = UIKeyboardType.numberPad
        return txtField
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Старт", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()
    
    func setUpView() {
        self.view.addSubview(infoLabel)
        self.view.addSubview(submitButton)
        self.view.addSubview(numberOfPlayersTextField)
        
        infoLabel.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(316)
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        numberOfPlayersTextField.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        submitButton.snp.makeConstraints {
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.top.equalTo(numberOfPlayersTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        submitButton.addTarget(self, action: #selector(didTapStartBtn), for: .touchUpInside)
        setUpView()
    }
    

    @objc func didTapStartBtn(_ sender: UIButton){
        if(numberOfPlayersTextField.text != ""){
            let numberOfPlayers = Int(numberOfPlayersTextField.text!) ?? 0
            print(numberOfPlayers)
            if(numberOfPlayers >= 4){
                let locationViewController = LocationViewController()
                locationViewController.game = GameGenerator.generateGame(Int(numberOfPlayersTextField.text!) ?? 0)
                self.present(locationViewController, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "УПС ⚠️", message: "Минимальное количество игроков 4",  preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "Ок", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
