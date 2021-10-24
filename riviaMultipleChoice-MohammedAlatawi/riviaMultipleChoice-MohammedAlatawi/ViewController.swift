//
//  ViewController.swift
//  riviaMultipleChoice-MohammedAlatawi
//
//  Created by محمد العطوي on 15/03/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var valueScoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButton: UIButton!
    
    var Score:Int = 0
    
    var selectedAnswer:Int = 0
    
    var questionNumber1: Int = 0
    
    var questionBank = QuestionBank ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
        questionLabel.text = questionBank.getQuestion()
        optionFirstButton.setTitle(questionBank.getAnswers(Index: 0), for: .normal)
        optionSecondButton.setTitle(questionBank.getAnswers(Index: 1), for: .normal)
        optionThirdButton.setTitle(questionBank.getAnswers(Index: 2), for: .normal)
        optionFourthButton.setTitle(questionBank.getAnswers(Index: 3), for: .normal)
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.titleLabel?.text
        if questionBank.checkAnswers(userAnswer!) {
            print("Correct")
            sender.backgroundColor = UIColor.green
        }else {
            print("Incorrect")
            sender.backgroundColor = UIColor.red
            
        }

        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatwUi), userInfo: nil, repeats: false)
        questionNumber1 += 1
    }
    
    @objc func updatwUi() {
        questionBank.nextQuestionIndx()
        questionLabel.text = questionBank.getQuestion()
        optionFirstButton.setTitle(questionBank.getAnswers(Index: 0), for: .normal)
        optionSecondButton.setTitle(questionBank.getAnswers(Index: 1), for: .normal)
        optionThirdButton.setTitle(questionBank.getAnswers(Index: 2), for: .normal)
        optionFourthButton.setTitle(questionBank.getAnswers(Index: 3), for: .normal)
        
        progressBar.progress = questionBank.getprogress()
        
        valueScoreLabel.text = "Score:\(questionBank.getScore())"
        optionFirstButton.backgroundColor = UIColor.white
        optionSecondButton.backgroundColor = UIColor.white
        optionThirdButton.backgroundColor = UIColor.white
        optionFourthButton.backgroundColor = UIColor.white
        
        
    }
    
    /* func updateInterFace(){
     valueScoreLabel.text = ("Scor \(Score)")
     questionNumber.text = "\(questionNumber1 += 1) / \(questionBank.questions.count)"
     
     progressBar.progress = Float(Float(questionNumber1 + 1) / Float(questionBank.questions.count))*/
    
    
    
    func reStart() {
        Score = 0
        questionNumber1 = 0
        updatwUi()
    }
}

