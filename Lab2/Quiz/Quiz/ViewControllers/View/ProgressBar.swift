//
//  ProgressBar.swift
//  Quiz
//
//  Created by Arthur Belyankov on 3/7/19.
//  Copyright © 2019 Nurzhan. All rights reserved.
//

import UIKit


class ProgressBar: UIView{
    var leftMargin:CGFloat = 20.0
    var numberOfSteps: Int = 0 {
        didSet {
            setupLayout()
        }
    }
    var dots = [Dot]()
    
    var widthConstrain: NSLayoutConstraint!
    
    var backLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var frontLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    var distanceBetweenDots: CGFloat!{
        return (UIScreen.main.bounds.width - (leftMargin * 2.0)) / CGFloat(integerLiteral: numberOfSteps - 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        widthConstrain = NSLayoutConstraint(item: frontLine, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0)
        
        self.addSubview(backLine)
        backLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            backLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            backLine.heightAnchor.constraint(equalToConstant: 6),
            backLine.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        setupLayout()
        
        
        addSubview(frontLine)
        frontLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            frontLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            frontLine.heightAnchor.constraint(equalToConstant: 2),
            frontLine.centerYAnchor.constraint(equalTo: backLine.centerYAnchor)
        ])
        frontLine.addConstraint(widthConstrain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        for i in 0...numberOfSteps {
            let dot = Dot()
            self.addSubview(dot)
            dot.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(leftMargin + (CGFloat(i) * distanceBetweenDots))),
                dot.centerYAnchor.constraint(equalTo: centerYAnchor),
                dot.heightAnchor.constraint(equalToConstant: 16),
                dot.widthAnchor.constraint(equalToConstant: 16)
            ])
            dots.append(dot)
        }
    }
    
    func setSelection(at index: Int){
        let dot: Dot = dots[index]
        widthConstrain.constant = (leftMargin + (CGFloat(index) * distanceBetweenDots))
        UIView.animate(withDuration: 0.6, animations: {
            self.layoutIfNeeded()
        }) { (succes) in
            dot.isComplete = true
        }
    }
}

class Dot: UIView {
    
    var completeColor: UIColor = UIColor.red
    var unCompleteColor: UIColor = UIColor.white
    
    let completeDot: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.6
        return view
    }()
    
    var isComplete: Bool? = false{
        didSet{
            setupColor()
        }
    }
    
    func setupColor() {
        if isComplete! {
            self.animate(with: completeColor)
        }else {
            self.animate(with: unCompleteColor)
        }
    }
    
    func animate(with color: UIColor) {
        UIView.animate(withDuration: 0.1, animations: {
            self.completeDot.backgroundColor = color
        }, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(completeDot)
        completeDot.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completeDot.centerXAnchor.constraint(equalTo: centerXAnchor),
            completeDot.centerYAnchor.constraint(equalTo: centerYAnchor),
            completeDot.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            completeDot.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
            ])
        
        self.layer.cornerRadius = 8
        setupColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

