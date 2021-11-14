//
//  QuestionBank.swift
//  TriviaMultipleChoice "Yousef Albalawi"
//
//  Created by Yousef Albalawi on 17/03/1443 AH.
//

import Foundation
struct QuizManager {
  
  let quiz = [
    
    
    
    Question(question: "Which continent is the larges ?",
             choices: ["Asia", "Europe", "America", "Africa"],
             answer: "Asia"),
    Question(question: "What is the capital of New Zealand ? ",
             choices: ["Washington","London","Riyadh","Wellington"],
             answer: "Wellington"),
    Question(question: "Who is the hero of Game of Thrones ? ",
             choices: ["Arya", "Jon Snow","Mother of Dragons", "Joffrey"],
             answer: "Jon Snow"),
    Question(question: "What is the first international Saudi club ? ",
             choices: ["Alnaser", "Alhlal","Alahli","Alathhad"],
             answer: "Alnaser"),
    Question(question: "Who is the current crown prince of Saudi Arabia ? ",
             choices: ["Mohammed bin Salman", "Khalid Al-Faisal", "AbdulRahman bin Musaed", "Badr bin Abdul Mohsen"],
             answer: "Mohammed bin Salman")]
  
  
  
  private var questionNumber = 0
  var score = 0
  
  
  
  mutating func checkAnswer(_ userAnswer:String) -> Bool {
    print(userAnswer)
    print(quiz[questionNumber].answer)
    if userAnswer == quiz[questionNumber].answer{
      score += 5
      return true
    }
    
    
    score -= 10
    return false
    
    
  }
  func checkQuestion() -> String {
    return quiz[questionNumber].question
    
    
  }
  func checkChoices() -> [String] {
    return quiz[questionNumber].choices
    
    
  }
  func checkProgress() -> Float {
    return Float(questionNumber) / Float(quiz.count);
    
    
  }
  func checkScore() -> Int {
    return score
    
    
  }
  
  
  mutating func nextQuestion() -> Bool {
    //questionNumber += 1
    if (questionNumber + 1 < quiz.count){
      questionNumber += 1
      //  questionNumber = 0
      //   score = 0
      return true
    }
    else{
     
    
    questionNumber = 0
    score = 0
    return false
  }
//
  //
}
}
