//
//  QuestionBank.swift
//  TriviaMultipleChoice
//
//  Created by azooz alhwiti on 18/03/1443 AH.
//

import Foundation

struct QuestionBank {
  private let question = [
        Question(question: "Which is the world's tallest peak?",
                 answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"],
                 correctAnswer: "Everest"),
        
        Question(question: "Which is the Capital of Australia?",
                 answers: ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"],
                 correctAnswer: "Canberra"),
        
        Question(question: "Rigoletto opera was composed by",
                 answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart",
               "Giuseppe Verdi", "Richard Wagner"],
                 correctAnswer: "Giuseppe Verdi"),
        
        Question(question: "Turandot opera was composed by",
                 answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"],
                   correctAnswer: "Giacomo Puccini"),
        
        Question(question: "The magic flute opera was composed by",
                 answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"],
                   correctAnswer: "Wolfgang Amadeus Mozart")
    ]
    
    func getQuestions() -> [Question] {
        return question
    }
}
