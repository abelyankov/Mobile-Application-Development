//
//  ViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var numberOfPlayersTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.addTarget(self, action: #selector(didTapStartBtn), for: .touchUpInside)
    }
    
    @objc func didTapStartBtn(_ sender: UIButton){
        if(numberOfPlayersTextField.text != ""){
            let locationViewController =
                storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
            
            locationViewController.game = GameGenerator.generateGame(Int(numberOfPlayersTextField.text!) ?? 0)
            self.present(locationViewController, animated: true, completion: nil)
        }
    }
}

