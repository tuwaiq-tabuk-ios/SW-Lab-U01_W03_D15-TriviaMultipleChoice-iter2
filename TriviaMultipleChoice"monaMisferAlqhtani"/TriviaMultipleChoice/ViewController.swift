//
//  ViewController.swift
//  TriviaMultipleChoice
//
//  Created by mac on 23/10/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet internal weak var valueScoreLabel: UILabel!
    
    @IBOutlet internal weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionFirstButton: UIButton!
    
    @IBOutlet weak var optionSecondButton: UIButton!
    
    @IBOutlet weak var optionThirdButton: UIButton!
    
    @IBOutlet weak var optionFourthButton: UIButton!
    
    @IBOutlet internal weak var progressBar: UIProgressView!
    
    var scoreValue = 0
    
    var activeQuestion = 0
    
    var audio: AVPlayer?
    
    private let questions = [
        SingleChoiceQuestion(
            question: "Which is the world's tallest peak?",
            answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"],
            correctAnswer: "Everest"
        ),
        SingleChoiceQuestion(
            question: "Which is the Capital of Australia?",
            answers: ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"],
            correctAnswer: "Canberra"
        ),
        SingleChoiceQuestion(
            question: "Rigoletto opera was composed by",
            answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart",
           "Giuseppe Verdi", "Richard Wagner"],
            correctAnswer: "Giuseppe Verdi"
        ),
        SingleChoiceQuestion(
            question: "Turandot opera was composed by",
            answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"],
            correctAnswer: "Giacomo Puccini"
        ),
        SingleChoiceQuestion(
            question: "The magic flute opera was composed by",
            answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"],
            correctAnswer: "Wolfgang Amadeus Mozart"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        configureButons()
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 4)
        progressBar.layer.cornerRadius = 6
        progressBar.clipsToBounds = true
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let buttons = [optionFirstButton, optionSecondButton, optionThirdButton, optionFourthButton]
        
        let question = questions[activeQuestion]
        
        if question.answers?[sender.tag] == question.correctAnswer {
            scoreValue += 5
            
            buttons[sender.tag]?.backgroundColor = .green
        } else {
            buttons[sender.tag]?.backgroundColor = .red
            
            for (index, value) in (question.answers ?? []).enumerated() {
                if value == question.correctAnswer {
                    buttons[index]?.backgroundColor = .green
                    break
                }
            }
            
            scoreValue += -10
        }
        
        
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(checkAnswerAndChangeQuestion), userInfo: nil, repeats: false)
        

        
    }

    func configureButons() {
        for btn in [optionFirstButton, optionSecondButton, optionThirdButton, optionFourthButton] {
            btn?.layer.borderColor = UIColor.white.cgColor
            btn?.layer.borderWidth = 3
            btn?.layer.cornerRadius = 20
        }
    }
    
    @objc func checkAnswerAndChangeQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            
            for btn in [self.optionFirstButton, self.optionSecondButton, self.optionThirdButton, self.optionFourthButton] {
                btn?.backgroundColor = .clear
            }
            
            if self.activeQuestion < self.questions.count - 1 {
                self.activeQuestion += 1
                self.updateData()
            } else {
                self.hasUserGoodScore()
            }
        }
    }
    
    func hasUserGoodScore() {
        let success = Float(self.scoreValue) >= 17.5
        playSound(isCorrectAnswer: success)
        let title = success ? "Congratulations" : "Game Over"
        let alert = UIAlertController(title: title, message: "Your score is \(self.scoreValue)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Play again", style: UIAlertAction.Style.default, handler: { _ in
            self.scoreValue = 0
            self.activeQuestion = 0
            self.updateData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateData() {
        let buttonsTitle = questions[activeQuestion].answers
        valueScoreLabel.text = "\(scoreValue)"
        questionLabel.text = questions[activeQuestion].question
        progressBar.progress = Float(activeQuestion + 1) / Float(questions.count)
        
        optionFirstButton.setTitle(buttonsTitle?[0], for: .normal)
        optionSecondButton.setTitle(buttonsTitle?[1], for: .normal)
        optionThirdButton.setTitle(buttonsTitle?[2], for: .normal)
        optionFourthButton.setTitle(buttonsTitle?[3], for: .normal)
    }
    
    func playSound(isCorrectAnswer: Bool) {
        
        guard let url = Bundle.main.url(forResource: isCorrectAnswer ? "correct" : "error", withExtension: "mp3") else {
            return
        }
        
        audio = AVPlayer(url: url)
        
        guard let audio = audio else {
            return
        }
        
        audio.play()
    }
    
}

