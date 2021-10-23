

import Foundation

struct QuizBrain {
  
  internal var questionNumber = 0
  private var score = 0.0
  
  internal let questions = [
    
    Question ( question: "Which is the world's tallest peak?",
               answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"],
               correctAnswer: "Everest"),
    
    Question ( question: "Which is the Capital of Australia?",
               answers : ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"],
               correctAnswer : "Canberra"),
    
    Question ( question: "Rigoletto opera was composed by ",
               answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi", "Richard Wagner"],
               correctAnswer: "Giuseppe Verdi"),
    
    Question ( question: "Turandot opera was composed by",
               answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"],
               correctAnswer: "Giacomo Puccini"),
    
    Question ( question: "The magic flute opera was composed by",
               answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"],
               correctAnswer:  "Wolfgang Amadeus Mozart")
  ]
  
  
  mutating func getTheAnswer (_ selectedAnswer : String) -> Bool {
    
    if questionNumber < questions.count {
      if selectedAnswer == questions[questionNumber].correctAnswer {
        score += 5
        return true
      }
      
      else {
        score -= 10
        return false
      }
    }
    
   else {
      return false
    }
  }
  
  
  
  func getAnswers() -> [String] {
    
    if questionNumber < questions.count {
      
      return questions[questionNumber].answers
    }
    return questions[questions.count - 1].answers
  }
  
  
  func getTheProgress() -> Float {
    
    return Float(questionNumber) / Float(questions.count)
  }
  
  
  func getTheQuestion() -> String {
    
    if questionNumber < questions.count {
      
      return questions[questionNumber].question
    }
    return questions[questions.count - 1].question
  }
  
  
  mutating func nextQuestion () -> Bool {
    
    if questionNumber <= questions.count {
      
      questionNumber += 1
      return true
    }
    
    else {
      questionNumber = 0
      return false
    }
  }
  
  
  func getTheScore () -> Double {
    
    return score
  }
  
  
  func hasUserGoodScore() -> Bool {
    
    // ternary conditional operation to check if the score is higher than 17:
    let isScoreHigh = (getTheScore() > 17.5) ? true : false
    return isScoreHigh
  }
  
}
