//
//  QuestionBank.swift
//  TriviMultipleChoice_App
//
//  Created by Mohammed on 15/03/1443 AH.
//

import Foundation

struct QuestionsBrain {
  
  let listOfQuestions = [
    
    
    
    Question(question: "When Saudi Arabia founded?",
             answers: ["1967", "1935", "1922", "1932"],
             correctAnswer:"1932"),
    Question(question: "What is the fastest animal?",
             answers: ["Cheetah","Falcon","Shark","Monkey"],
             correctAnswer:"Falcon"),
    Question(question: "The founder of Apple is?",
             answers: ["Bill Gates", "Steve Jobs","Elon Mask", "Jeff Bezos"],
             correctAnswer:"Steve Jobs"),
    Question(question: "Toyota is .....company",
             answers: ["American", "Korean","Japanese","Chinese"],
             correctAnswer: "Japanese"),
    Question(question: "King Faisal bin Abdulaziz was the....king of Saudi Arabia?",
             answers:["Third", "Fifth", "First", "Second"],
             correctAnswer: "Third")]
   
  
  
  
  private var questionNumber = 0
  var score = 0
  
    
  mutating func checkTheAnswer(_ userAnswer:String) -> Bool {
    print(userAnswer)
    print(listOfQuestions[questionNumber].correctAnswer)
    if userAnswer == listOfQuestions[questionNumber].correctAnswer{
      score += 5
      return true
    }
    
    
    score -= 10
    return false
    
    
  }
  func checkQuestion() -> String {
    return listOfQuestions[questionNumber].question
    
    
  }
  func checkAnswers() -> [String] {
    return listOfQuestions[questionNumber].answers
    
    
  }
  func checkProgress() -> Float {
    return Float(questionNumber) / Float(listOfQuestions.count);
    
    
  }
  func checkScore() -> Int {
    return score
    
    
  }
  
  
  mutating func nextQuestion() -> Bool {
    //questionNumber += 1
    if (questionNumber + 1 < listOfQuestions.count){
      questionNumber += 1
      //  questionNumber = 0
      //   score = 0
      return true
    }
    else{
      return false
    }
  }
    
    
    func getScore()-> Int {
      return score
    }
    
  
  mutating func start() {
    questionNumber = 0
    score = 0
  }
    
    
    mutating func startGame(){
      score = 0
      questionNumber = 0
    }
}

