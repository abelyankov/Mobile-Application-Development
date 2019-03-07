import Foundation

class Api {
    
    static func getQuestions(succes: ([Question]) -> Void) {
        
        let path = Bundle.main.path(forResource: "questions", ofType: "json")
        
        guard let filePath = path else {
            return
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: url)
            let questions = try JSONDecoder().decode(Questions.self, from: data)
            succes(questions.questions)
        }catch let error {
            print(error)
        }
    }
}

struct Questions: Decodable {
    var questions: [Question]
}

struct Question: Decodable {
    var id: String
    var text: String
    var variants: [String]
    var answer: Int
    var bonus: Int
    var imageUrl: String
}
