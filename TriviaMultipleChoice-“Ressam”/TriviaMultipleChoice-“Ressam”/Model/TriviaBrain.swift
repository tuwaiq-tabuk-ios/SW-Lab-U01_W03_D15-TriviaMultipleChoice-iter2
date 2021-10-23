//
//  TriviaBrain.swift
//  TriviaMultipleChoice-“Ressam”
//
//  Created by Ressam Al-Thebailah on 17/03/1443 AH.
//

import Foundation
struct TriviaBrain {
  
  let questions = [
    Question(question:"Which is the world's tallest peak?",
             answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"],
             correctAnswer: "Everest"),
    
    Question(question: "Which is the Capital of Australia?",
             answers:["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"]
             , correctAnswer:"Canberra"),
    
    Question(question: "Rigoletto opera was composed by",
             answers:["Giacomo Puccini", "Wolfgang Amadeus Mozart",
                      "Giuseppe Verdi", "Richard Wagner"],
             correctAnswer: "Giuseppe Verdi"),
    
    Question(question: "Turandot opera was composed by",
             answers:["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart","Giuseppe Verdi"] ,
             correctAnswer: "Giacomo Puccini"),
    
    Question(question:"The magic flute opera was composed by",
             answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozrat","Richard Wagner"],
             correctAnswer:"Wolfgang Amadeus Mozrat"),
  ]
}
