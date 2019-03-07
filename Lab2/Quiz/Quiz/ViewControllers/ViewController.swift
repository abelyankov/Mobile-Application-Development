

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var startQuizButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonView()
    }
    
    func updateButtonView() {
        startQuizButton.layer.cornerRadius = 5
    }

    @IBAction func startQuizHandle(_ sender: UIButton) {
        let quizViewController = QuizViewController()
        quizViewController.view.backgroundColor = UIColor.black
        quizViewController.title = "Quiz 🤯"
        Api.getQuestions { (questions) in
            print(questions)
        }
        let alert = UIAlertController(title: "OI 😱", message: "Enter player name! PLS", preferredStyle: .actionSheet)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        if playerName.text != "" {
            quizViewController.userName = playerName.text!
            navigationController?.pushViewController(quizViewController, animated: true)
            
        }else {
            present(alert, animated: true, completion: nil)
        }
    }
}

