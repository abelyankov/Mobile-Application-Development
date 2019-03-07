//
//  QuizView.swift
//  Quiz
//
//  Created by Arthur Belyankov on 3/7/19.
//  Copyright © 2019 Nurzhan. All rights reserved.
//

import UIKit

class QuizView: UIView {
    
    var onAnswer: ((Int) -> Void)?
    var onTimeEnd: (() -> Void)?
    var question: Question? {
        didSet {
            guard let question = question else {
                return
            }
            display(question: question)
        }
    }
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.tag = 5
        return progress
    }()
    
    let questionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "text Question"
        label.textColor = UIColor.white
        label.tag = 90
        return label
    }()
    
    let questionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.gray
        image.tag = 9
        return image
    }()
    
    let firstButton: AnswerButton = {
        let button = AnswerButton()
        button.addTarget(self, action: #selector(answerButtonHandle(sender:)), for: .touchUpInside)
        button.setTitle("Var 1", for: .normal)
        button.tag = 0
        return button
    }()
    
    let secondButton: AnswerButton = {
        let button = AnswerButton()
        button.addTarget(self, action: #selector(answerButtonHandle(sender:)), for: .touchUpInside)
        button.setTitle("Var 2", for: .normal)
        button.tag = 1
        return button
    }()
    
    let thirdButton: AnswerButton = {
        let button = AnswerButton()
        button.addTarget(self, action: #selector(answerButtonHandle(sender:)), for: .touchUpInside)
        button.setTitle("Var 3", for: .normal)
        button.tag = 2
        return button
    }()
    
    let fourthButton: AnswerButton = {
        let button = AnswerButton()
        button.addTarget(self, action: #selector(answerButtonHandle(sender:)), for: .touchUpInside)
        button.setTitle("Var 4", for: .normal)
        button.tag = 3
        return button
    }()
    
    var timer: Timer!
    
    init() {
        super.init(frame: .zero)
        self.tag = 89
        addSubview(questionText)
        NSLayoutConstraint.activate([
                questionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                questionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                questionText.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
        
        addSubview(questionImage)
        NSLayoutConstraint.activate([
                questionImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                questionImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                questionImage.heightAnchor.constraint(equalToConstant: 300),
                questionImage.topAnchor.constraint(equalTo: questionText.bottomAnchor, constant: 10)
        ])
        
        let stackView_row1 = UIStackView(arrangedSubviews: [firstButton, secondButton])
        stackView_row1.axis = .vertical
        stackView_row1.tag = 43
        stackView_row1.distribution = .fillEqually
        stackView_row1.translatesAutoresizingMaskIntoConstraints = false
        stackView_row1.spacing = 10
        let stackView_row2 = UIStackView(arrangedSubviews: [thirdButton, fourthButton])
        stackView_row2.axis = .vertical
        stackView_row2.tag = 43
        stackView_row2.translatesAutoresizingMaskIntoConstraints = false
        stackView_row2.distribution = .fillEqually
        stackView_row2.spacing = 10
        
        
        let mainStackView = UIStackView(arrangedSubviews: [stackView_row1, stackView_row2])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
        mainStackView.tag = 43
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.heightAnchor.constraint(equalToConstant: 130),
            mainStackView.topAnchor.constraint(equalTo: questionImage.bottomAnchor, constant: 20),
        ])
        
        addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            progressBar.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            progressBar.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
    
    func display(question: Question) {
        
        firstButton.backgroundColor = UIColor.white
        secondButton.backgroundColor = UIColor.white
        thirdButton.backgroundColor = UIColor.white
        fourthButton.backgroundColor = UIColor.white
        
        firstButton.isUserInteractionEnabled = true
        secondButton.isUserInteractionEnabled = true
        thirdButton.isUserInteractionEnabled = true
        fourthButton.isUserInteractionEnabled = true
        
        questionText.text = "\(question.text)"
        firstButton.setTitle("\(question.variants[0])", for: .normal)
        secondButton.setTitle("\(question.variants[1])", for: .normal)
        thirdButton.setTitle("\(question.variants[2])", for: .normal)
        fourthButton.setTitle("\(question.variants[3])", for: .normal)
        downloadImage(url: question.imageUrl) { (image) in
            self.questionImage.image = image
            
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timerRunning), userInfo: nil, repeats: false)

        }
    }
    
    func displayCorrectAnswer(correctIndex: Int, wrongIndex: Int, succes: @escaping () -> Void){
        let correctButton: UIButton = viewWithTag(correctIndex) as! UIButton
        correctButton.backgroundColor = UIColor.green
        
        let wrongButotn: UIButton = viewWithTag(wrongIndex) as! UIButton
        wrongButotn.backgroundColor = UIColor.red
        
        firstButton.isUserInteractionEnabled = false
        secondButton.isUserInteractionEnabled = false
        thirdButton.isUserInteractionEnabled = false
        fourthButton.isUserInteractionEnabled = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            succes()
        }
        
    }
    
    @objc func timerRunning() {
        let timeRemaining = 3
        let totalTime = 3
        let completionPercentage = Int(((Float(totalTime) - Float(timeRemaining))/Float(totalTime)) * 100)
        progressBar.setProgress(Float(timeRemaining)/Float(totalTime), animated: true)
        onTimeEnd?()
    }
    
    func downloadImage(url: String, succes: @escaping (UIImage) -> Void) {
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    succes(image!)
                }
            }
        }
        session.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func answerButtonHandle(sender: AnswerButton) {
        timer.invalidate()
        onAnswer?(sender.tag)
    }
    
}


class AnswerButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        setTitleColor(UIColor.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
