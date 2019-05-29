//
//  MainViewController.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/28/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit
import SnapKit
import AccountKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController,
                          AKFViewControllerDelegate,
                          UITableViewDataSource,
                          UITableViewDelegate {
    
    var accountKit: AccountKit!
    var array = [Game]()
    var tapindx: [IndexPath: Bool] = [:]
    
    var refreshControl = UIRefreshControl()
    
    let nameLabel:  UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "Find Spy Game"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        nameLabel.font = UIFont(name: "Helvetica", size: 20)
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.transform = CGAffineTransform(rotationAngle:  CGFloat(Double(-3) * .pi/180))
        return nameLabel
    }()
    
    let hatImageView: UIImageView = {
        let ov = UIImageView()
        ov.image = #imageLiteral(resourceName: "hat-1")
        return ov
    }()
    
    var gameTableView : UITableView = {
        let tableview = UITableView()
        let refreshControl = UIRefreshControl()
        tableview.register(GameTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableview.scrollsToTop = true

        tableview.separatorColor = .white
        tableview.layer.cornerRadius = 20
        
        return tableview
    }()
    
    let createGameBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.setTitle("Создать игру", for:  .normal)
        btn.setTitleColor(UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0), for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        setupView()
        Modelcall()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        createGameBtn.addTarget(self, action: #selector(createGameController), for: .touchUpInside)
        gameTableView.addSubview(refreshControl)

    }
    
    @objc func refresh(_ sender: Any) {
        Modelcall()
        refreshControl.endRefreshing()
    }
    
    func setupView() {
        
        self.view.addSubview(hatImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(gameTableView)
        self.view.addSubview(createGameBtn)
        
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
        gameTableView.snp.makeConstraints {
            $0.height.equalTo(346)
            $0.width.equalTo(316)
            $0.top.equalTo(nameLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        gameTableView.delegate = self
        gameTableView.dataSource = self
        
        createGameBtn.snp.makeConstraints {
            $0.top.equalTo(gameTableView.snp.bottom).offset(20)
            $0.width.equalTo(272)
            $0.height.equalTo(51)
            $0.centerX.equalToSuperview()
        }
        

    }
    

    @objc func createGameController(_ sender: UIButton){
        let createGameController = StartViewController()
        self.present(createGameController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GameTableViewCell
        cell.name.text = "Игра #" + String(array[indexPath.row].game_id)
        cell.numberOfPlayers.text = "Количетсво игроков: " + String(array[indexPath.row].readyPlayerNumber) + "/" + String(array[indexPath.row].totalNumberOfPlayers) + ";"
        if array[indexPath.row].finishedPlayerNumber != array[indexPath.row].totalNumberOfPlayers {
            cell.endGame.text = "Игра идёт"
            cell.endGame.textColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        } else {
            cell.endGame.text = "Завершена"
            cell.endGame.textColor = .red
        }
        cell.delegate = self as? CellDelegate

        return cell
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        gameTableView.reloadData()
    }
    
    func Modelcall(){
        Game.Games{(cats) in
            self.array = cats
            self.gameTableView.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func didTap(_ cell: GameTableViewCell) {
    let indexPath = self.gameTableView.indexPath(for: cell)!
        if let actionname = cell.BTN.titleLabel?.text {
            if let _ = tapindx[indexPath] {
                if actionname == "Join"{
                    print("hell")
                    self.array[indexPath.row].type = 1
                    cell.state = 1
                    let URL = "http://192.168.43.48:8080/join_game/"
                    let user = UserDefaults.standard.string(forKey: "user_id")
                    Alamofire.request(URL, method: .get, parameters: ["gameId": array[indexPath.row].game_id!, "playerId": user!])
                        .responseJSON { response in
                            print(response.request)
                            print(response.response)
                            print(response.result)
                            if let value = response.result.value {
                                print("Did receive JSON data: \(value)")
                                var location = JSON(value)["location"].stringValue
                                UserDefaults.standard.set(location, forKey: "location")
                                let locations = UserDefaults.standard.string(forKey: "location")
                                print("AAAA Location")
                                print(locations!)
                                let locationViewController = LocationViewController()
                                self.present(locationViewController, animated: true, completion: nil)
                            }
                            else {
                                print("JSON data is nil.")
                            }
                    }
                    tapindx[indexPath] = true
                }
            }
            self.gameTableView.reloadData()
        }
    }
}

