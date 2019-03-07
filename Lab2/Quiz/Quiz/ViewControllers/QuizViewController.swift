import UIKit

class QuizViewController: UIViewController {
    
    let progeress: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    
    var quizView = QuizView()
    
    var userName: String = ""
    var questions: [Question] = []
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Api.getQuestions { (questions) in
            self.questions = questions
        }
        view.addSubview(progeress)
        NSLayoutConstraint.activate([
            progeress.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progeress.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progeress.heightAnchor.constraint(equalToConstant: 6),
            progeress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)
        ])
        
        view.addSubview(quizView)
        quizView.translatesAutoresizingMaskIntoConstraints = false
        quizView.backgroundColor = UIColor.black
        NSLayoutConstraint.activate([
            quizView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            quizView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            quizView.topAnchor.constraint(equalTo: progeress.bottomAnchor, constant: 10),
            quizView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
        quizView.question = questions[0]
        quizView.onAnswer = { [weak self] buttonTag in
            self?.checkAnswer(selectedAnswer: buttonTag)
        }
        quizView.onTimeEnd = {
            self.errorAnimation(succes: { (succes) in
                self.displayQuestion()
            })
        }
    }
    
    func displayQuestion() {
        
        
        currentQuestionIndex = currentQuestionIndex + 1
        let progressFloat = Float( currentQuestionIndex / questions.count)
        progeress.setProgress(progressFloat, animated: true)
        if currentQuestionIndex > questions.count - 1 {
            endQuiz()
        }else {
          
            quizView.question = questions[currentQuestionIndex]
        }
    }
    
    func checkAnswer(selectedAnswer: Int) {
        guard let question = quizView.question else {
            return
        }
        if question.answer == selectedAnswer {
            succesAnimation { (succes) in
               self.displayQuestion()
            }
        }else{
            errorAnimation { (succes) in
                self.quizView.displayCorrectAnswer(correctIndex: question.answer, wrongIndex: selectedAnswer, succes: {
                    self.displayQuestion()
                })
            }
        }
    }
    
    func endQuiz() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func succesAnimation(succes: @escaping (Bool) -> ()) {
        UIView.transition(with: quizView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: succes)
    }
    
    private func errorAnimation(succes: (Bool) -> Void) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        }
        quizView.layer.add(animation, forKey: "position")
        succes(true)
    }
}
