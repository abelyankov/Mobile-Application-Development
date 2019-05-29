//
//  GameTableViewCell.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/28/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import UIKit
import Alamofire

protocol CellDelegate {
    func didTap(_ cell: GameTableViewCell)
}

class GameTableViewCell: UITableViewCell {
    
    var state = Int() {
        didSet{
            statusFunc(s: state)
        }
    }

    var delegate: CellDelegate?
    
    var urlData: String!
    var namefile: String!
    
    var name: UILabel = {
        let label1 = UILabel()
        label1.textColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        label1.font = UIFont(name: "Helvetica", size: 19)
        return label1
    }()
    
    var numberOfPlayers: UILabel = {
        let label1 = UILabel()
        label1.textColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        label1.font = UIFont(name: "Helvetica", size: 14)
        return label1
    }()
    
    var endGame: UILabel = {
        let label1 = UILabel()
        label1.textColor = UIColor(red: 1/255, green: 31/255, blue: 69/255, alpha: 1.0)
        label1.font = UIFont(name: "Helvetica", size: 14)
        return label1
    }()
    
    var BTN: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
//        btn.setTitleColor(.red, for: .normal)
//        btn.setImage(#imageLiteral(resourceName: "Shape"), for: .normal)

        return btn
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        Lable1()
    }
    
    func Lable1(){
        self.addSubview(name)
        self.addSubview(numberOfPlayers)
        self.addSubview(endGame)
        self.addSubview(BTN)
        
        BTN.addTarget(self, action: #selector(statusAction), for: .touchUpInside)
        BTN.snp.makeConstraints{
            $0.top.equalTo(name.snp.top).offset(2)
            $0.right.equalTo(-15)
            $0.height.equalTo(32)
            $0.width.equalTo(32)
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(20)
        }
        numberOfPlayers.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom)
            $0.left.equalTo(20)
        }
        
        endGame.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom)
            $0.left.equalTo(numberOfPlayers.snp.right).offset(5)
        }
    }
    
    @objc func statusAction(){
        delegate?.didTap(self)
        print("TAP")
        
    }
    
    func statusFunc(s: Int){
        switch s {
        case 1:
            BTN.setTitleColor(.red, for: .normal)
            BTN.setTitle("Join", for: .normal)
        default:
            print("Error")
            
        }
    }
}
