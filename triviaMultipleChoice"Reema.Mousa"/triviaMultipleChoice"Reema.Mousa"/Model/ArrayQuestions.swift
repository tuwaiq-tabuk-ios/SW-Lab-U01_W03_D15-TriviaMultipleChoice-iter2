import Foundation

struct QuastionBank {
  
  
  var score = 0
  var questionNumber = 0
  
  var rightchoice = 0
  var wrongchoice = 0
  
  private var quiz = [
    
    Question( question: "Q1 : How many planets are in our solar system?", answer: ["8 planets" ,"7 planets" ,"9 planets","10 planets"], correctAnswer: "8 planets"),
    
    Question( question: "Q2 : What is the largest planet?", answer: ["planet Purchaser" ,"planet  Mercury" ,"planet  Pluto","planet Uranus"], correctAnswer: "planet Purchaser"),
    
    
    Question( question: "Q3 : What is the closest planet to the sun?", answer: ["planet Purchaser" ,"planet Mercury" ,"planet Pluto"," planet Neptune"], correctAnswer: "planet Mercury"),
    
    Question( question: "Q4 : What is the farthest planet from the sun?", answer: ["planet Neptune" ,"planet Purchaser" ,"planet Pluto","Planet Earth"], correctAnswer: "planet Pluto"),
    
    Question( question: "Q5 : What is the only planet similar to Earth?", answer: ["Planet Mars" ,"planet Pluto" ,"planet Neptune","planet Purchaser"], correctAnswer: "Planet Mars"),
    
    Question( question: "Q6 : What is the planet that is characterized by its blue color?", answer: ["planet Neptune" ,"planet Purchaser" ,"Planet Earth","planet Venus"], correctAnswer: "Planet Earth"),
    
    Question( question: "Q7 : What is the smallest planet?", answer: ["planet Mercury" ,"planet Pluto" ,"planet Purchaser","planet Uranus"], correctAnswer: "planet Mercury"),
    
    Question( question: "Q8 : What planet has winds, volcanoes and clouds other than Earth?", answer: ["planet Purchaser" ,"Planet Mars" ,"planet Purchaser","planet Neptune"], correctAnswer: "Planet Mars"),
    
    Question( question: "Q9 : What is the brightest planet at night after the moon?", answer: ["planet Neptune" ,"planet Purchaser" ,"planet Pluto","planet Venus"], correctAnswer: "planet Venus"),
    
    Question( question: "Q10 : What planet is four times the size of Earth?", answer: ["Planet Mars" ,"planet Neptune" ,"planet Venus","planet Purchaser"], correctAnswer: "planet Neptune")
    
  ]
  
  
  func getQuestion ()->String{
    
    return quiz[questionNumber].question
  }
  
  mutating func nextQuestion ()-> Bool
  {
    if questionNumber + 1 < quiz.count
    {
      questionNumber += 1
      
      return true
    }
    else {
      
      return false
    }
    
    
  }
  func checkAnswers() -> [String] {
    quiz[questionNumber].answer
    
  }
  
  mutating func rightAnswer (_ rightAnswer:String) -> Bool{
    
    
    if rightAnswer == quiz[questionNumber].correctAnswer
    {
      score += 5
      
      rightchoice += 1
      return true
    }
    
    else
    
    {
      
      score -= 10
      wrongchoice += 1
      
      return false
    }
    
  }
  
  func getScore ()->Int
  {
    return score
  }
  
  
  func progrssBar () -> Float{
    
    return Float (questionNumber + 1) / Float (quiz.count)
    
  }
  
  mutating func startGame () {
    
    score = 0
    questionNumber = 0
    rightchoice = 0
    wrongchoice = 0
    
  }
  func getright ()-> Int {
    return rightchoice
  }
  
  func getwrong ()-> Int {
    return wrongchoice
  }
}

