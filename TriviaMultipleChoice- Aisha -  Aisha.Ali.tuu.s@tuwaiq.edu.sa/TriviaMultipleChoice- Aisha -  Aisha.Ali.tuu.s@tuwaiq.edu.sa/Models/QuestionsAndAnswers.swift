//
//  QuestionsAndAnswers.swift
//  TriviaMultipleChoice- Aisha -  Aisha.Ali.tuu.s@tuwaiq.edu.sa
//
//  Created by Aisha Ali on 10/22/21.
//

import Foundation

struct QuestionsAndAnswers {
  
  private var questionNumber = 0
  private var score = 0
  private var wrongAnswers = 0
  private  var rightAnswers = 0
  
  private let questionsList = [
    Questions(question:"Q1: Frodo was _____ At The Beginning Of The Fellowship Of The Ring."
              , answers: ["33", "24", "60", "30"]
              , correctAnswer: "33"),
    
    Questions(question:"Q2: Hobbits Live In ____."
              , answers: ["Hobbits Village", "Lonely Mountain","Bree", "Hogwarts"]
              , correctAnswer: "Bree"),
    
    Questions(question:"Q3: Durin's Folk Are  __"
              , answers: ["Hobbits", "Humans", "Dwarves", "Elfs"]
              , correctAnswer: "Dwarves"),
    //Which event led to the destruction of Númenor?
    Questions(question:"Q4: Which event led to the destruction of Númenor?"
              , answers: ["Númenóreans were willing to forge a new Ring of Power", "Númenóreans tried to sail to the Undying Lands", "Númenóreans planned to exterminate the Elven", "Non of Above"]
              , correctAnswer: "Númenóreans tried to sail to the Undying Lands"),
    
    Questions(question:"Q5: ___ Rings Were Given To Elves."
              , answers: ["3", "6", "3", "7"]
              , correctAnswer: "6"),
    
    Questions(question:"Q6: Gandalf Tells Aragorn To Look To The East On The ________ "
              , answers: ["First Light of Second Day", "First Light of Third Day", "Second Light of Second Day", "Second Light of Third Day"]
              , correctAnswer: "First Light of Third Day"),
    
    Questions(question:"Q7: Samwise Gamgee Is Frodo's ."
              , answers: ["Friend", "Cook", "Farmer", "Brother"]
              , correctAnswer: "Farmer"),
    
    Questions(question:"Q8: Isildur Is Aragorn's _____ ."
              , answers: ["Friend", "Grandfather", "Enemey", "Father"]
              , correctAnswer: "Father"),
    
    Questions(question:"Q9: The Witch King Of Angmar Used To Be An ___ ."
              , answers: ["Elf", "Hobbit", "Human", "Dwarves"]
              , correctAnswer: "Elf"),
    
    Questions(question:"Q10: The fellowship of the ring splits up at ___."
              , answers: ["Amon Hen", "Lonely Mountain", "Hogwarts", "Dwarves"]
              , correctAnswer: "Amon Hen"),
    
    Questions(question:"Q11: Gollum's hobbit name was___"
              , answers: ["Frodo", "Sam", "Jack", "Smeagol"]
              , correctAnswer: "Smeagol")
  ]
  
  
  mutating func getAnswer(_ selectedAnswer : String) -> Bool{
    
    let questionAnswer = questionsList[questionNumber].correctAnswer
    if selectedAnswer == questionAnswer{
      score += 5
      rightAnswers += 1
      return true
    }else{
      score -= 10
      wrongAnswers += 1
      return false
    }
  }
  
  
  func checkChoices() -> [String] {
    return questionsList[questionNumber].answers
  }
  
  
  func getQuestion() -> String {
    return questionsList[questionNumber].question
  }
  
  
  func getProgress() -> Float{
    return Float(questionNumber + 1) / Float(questionsList.count)
  }
  
  
  mutating func getNextQuestion() ->Bool{
    
    if questionNumber + 1  < questionsList.count{
      questionNumber += 1
      return true
    }else{
      return false
    }
  }
  
  
  func getScore() -> Int{
    return score
  }
  
  
  func getWrongAnswers() -> Int{
    return wrongAnswers
  }
  
  
  func getRightAnswers() -> Int{
    return rightAnswers
  }
  
  
  mutating func startGame(){
    questionNumber = 0
    score = 0
    wrongAnswers = 0
    rightAnswers = 0
  }
  
  func questionsArrayLength () -> Int{
    return questionsList.count
  }
  
}
