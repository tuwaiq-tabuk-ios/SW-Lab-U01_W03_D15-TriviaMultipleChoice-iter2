//
//  ViewController.swift
//  TrivaMultpleChoice2"Hajermohamed"
//
//  Created by hajer . on 18/03/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ValueScoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButtton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    var currentQuestionIndex = 0
    var secondsRemaining = 5
    var timer: Timer = Timer()
    var score = 0
    
    
    let questions = TriviaBrain.getQuestions()
    
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
        
        optionFourthButtton.clipsToBounds = true
        optionFourthButtton.layer.cornerRadius = 25
        optionFourthButtton.layer.borderWidth = 3
        optionFourthButtton.layer.borderColor = UIColor.white.cgColor
        optionFourthButtton.titleLabel?.adjustsFontSizeToFitWidth = true
        optionFourthButtton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    private func showQuestions() {
        optionFirstButton.backgroundColor = .clear
        optionSecondButton.backgroundColor = .clear
        optionThirdButton.backgroundColor = .clear
        optionFourthButtton.backgroundColor = .clear
        
        let percentageProgress = Float(currentQuestionIndex) / Float(questions.count)
        progressBar.progress = Float(percentageProgress)
        
        if currentQuestionIndex <= questions.count - 1 {
            print(currentQuestionIndex)
            
            questionLabel.text = questions[currentQuestionIndex].question
            
            optionFirstButton.setTitle(questions[currentQuestionIndex].answers[0], for: .normal)
            optionSecondButton.setTitle(questions[currentQuestionIndex].answers[1], for: .normal)
            optionThirdButton.setTitle(questions[currentQuestionIndex].answers[2], for: .normal)
            optionFourthButtton.setTitle(questions[currentQuestionIndex].answers[3], for: .normal)
        } else {
            showAlert()
        }
    }
    
    private func startTimer() {
        self.secondsRemaining = 5
        self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
            ValueScoreLabel.text = "\(score)"
        } else {
            score -= 10
            sender.backgroundColor = UIColor.red
            ValueScoreLabel.text = "\(score)"
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
            self.ValueScoreLabel.text = "\(self.score)"
            self.showQuestions()
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func answerButtonDidPressed(_ sender: UIButton) {
        startTimer()
        updateScore(userAnswer: sender.currentTitle!, sender: sender)
    }
}

