
import Foundation
struct QuastionManger {
  
  
  private var questionNumber = 0
   private var score = 0
  private var rightQuestion = 0
  private var wrongQuestion = 0
  private let quiz = [
    Question(question: "Which is the world's tallest peak?",
             answer: ["Klimanjaro hhhkkkkhgffdd ", "Everest", "Jabal Sawda", "Montblanc"],
             correctAnswer: "Everest"),
    
    
    Question(question: "Which is the Capital of Australia?",
             answer: ["Canberra", "Sydney", "Melbournehhh kkkkk", "Australia does nothave a capital"],
             correctAnswer: "Canberra"),
    
    
    Question(question: "Rigoletto opera was composed by?",
             answer: ["Giacomo Puccini", "Wolfgang Amadeus Mozart", "JGiuseppe Verdi", "Richard Wagner"],
             correctAnswer: "Giuseppe Verdi"),
    
    Question(question: "Rigoletto opera was composed by?",
             answer: ["Giacomo Puccini", "Wolfgang Amadeus Mozart", "JGiuseppe Verdi", "Richard Wagner"],
             correctAnswer: "Giuseppe Verdi"),
    
    
    Question(question: "what is the largest country in the world ?",
             answer: ["India", "Russia", "saudi Arabia", "Amirca"],
             correctAnswer: "Russia"),]
  
 

  
  
  mutating func checkAnswer(_ userAnswer:String) -> Bool {
      print(userAnswer)
      print(quiz[questionNumber].answer)
      if userAnswer == quiz[questionNumber].correctAnswer{
          score += 5
       rightQuestion += 1
          return true
      }
    score -= 10
  wrongQuestion += 1
    
      return false
  }
  
  func checkQuestion() -> String {
      return quiz[questionNumber].question
  }
  
  
  func checkChoices() -> [String] {
      return quiz[questionNumber].answer
  }
  
  
  func checkProgress() -> Float {
      return Float(questionNumber) / Float(quiz.count);
  }
  
  
  func checkScore() -> Int {
      return score
  }
  
  func getRightQuestions()-> Int{
    return rightQuestion
  }
  func getWrongQuestions()-> Int{
    return wrongQuestion
  }
  
  

  
  
  mutating func nextQuestion() -> Bool {
      
      if(questionNumber + 1 < quiz.count){
        questionNumber += 1
          return true
      }
      else{
        return false
      }
  }

  mutating func start() {
    questionNumber = 0
    score = 0
    wrongQuestion = 0
    rightQuestion = 0
  }
}


