//
//  ViewController.swift
//  TriviaMultipleChoice-BushraAlatawi
//
//  Created by bushra nazal alatwi on 15/03/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var valueScoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    let questions = TriviaBrain.getQuestions()
    
    var timer: Timer!
    var currentQuestionIndex = 0
    var secondsRemaining = 5
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButons()
        showQuestions()
    }
    
    
    private func configureButons() {
        optionFirstButton.clipsToBounds = true
        optionFirstButton.layer.cornerRadius = 25
        optionFirstButton.layer.borderWidth = 3
        optionFirstButton.layer.borderColor = UIColor.white.cgColor
        optionFirstButton.titleLabel?.adjustsFontSizeToFitWidth = true
        optionFirstButton.titleLabel?.minimumScaleFactor = 0.5
        
        optionSecondButton.clipsToBounds = true
        optionSecondButton.layer.cornerRadius = 25
        optionSecondButton.layer.borderWidth = 3
        optionSecondButton.layer.borderColor = UIColor.white.cgColor
        optionSecondButton.titleLabel?.adjustsFontSizeToFitWidth = true
        optionSecondButton.titleLabel?.minimumScaleFactor = 0.5
        
        optionThirdButton.clipsToBounds = true
        optionThirdButton.layer.cornerRadius = 25
        optionThirdButton.layer.borderWidth = 3
        optionThirdButton.layer.borderColor = UIColor.white.cgColor
        optionThirdButton.titleLabel?.adjustsFontSizeToFitWidth = true
        optionThirdButton.titleLabel?.minimumScaleFactor = 0.5
        
        optionFourthButton.clipsToBounds = true
        optionFourthButton.layer.cornerRadius = 25
        optionFourthButton.layer.borderWidth = 3
        optionFourthButton.layer.borderColor = UIColor.white.cgColor
        optionFourthButton.titleLabel?.adjustsFontSizeToFitWidth = true
        optionFourthButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    
    private func showQuestions() {
        optionFirstButton.backgroundColor = .clear
        optionSecondButton.backgroundColor = .clear
        optionThirdButton.backgroundColor = .clear
        optionFourthButton.backgroundColor = .clear
        
        let percentageProgress = Float(currentQuestionIndex) / Float(questions.count)
        progressBar.progress = Float(percentageProgress)
        
        if currentQuestionIndex <= questions.count - 1 {
            print(currentQuestionIndex)
            
            questionLabel.text = questions[currentQuestionIndex].question
            
            optionFirstButton.setTitle(questions[currentQuestionIndex].answers[0], for: .normal)
            optionSecondButton.setTitle(questions[currentQuestionIndex].answers[1], for: .normal)
            optionThirdButton.setTitle(questions[currentQuestionIndex].answers[2], for: .normal)
            optionFourthButton.setTitle(questions[currentQuestionIndex].answers[3], for: .normal)
        } else {
            showAlert()
        }
    }
    
    
    private func showAlert() {
        TriviaBrain.hasUserGoodScore(score: score)
        
        // create the alert
        let alert = UIAlertController(title: "GAME OVER", message: "Your score is \(score)", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (_) in
            self.currentQuestionIndex = 0
            self.score = 0
            self.valueScoreLabel.text = "\(self.score)"
            self.showQuestions()
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func startTimer() {
        self.secondsRemaining = 5
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            print("Seconds Remaining = \(secondsRemaining)")
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            currentQuestionIndex += 1
            showQuestions()
        }
    }
    
    
    private func updateScore(userAnswer: String, sender: UIButton) {
        if userAnswer == questions[currentQuestionIndex].correctAnswer {
            score += 5
            sender.backgroundColor = UIColor.green
            valueScoreLabel.text = "\(score)"
        } else {
            score -= 10
            sender.backgroundColor = UIColor.red
            valueScoreLabel.text = "\(score)"
        }
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        startTimer()
        updateScore(userAnswer: sender.currentTitle!, sender: sender)
    }
    
}



