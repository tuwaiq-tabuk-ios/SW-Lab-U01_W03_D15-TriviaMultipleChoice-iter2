//
//  ViewController.swift
//  riviaMultipleChoice-MohammedAlatawi
//
//  Created by محمد العطوي on 15/03/1443 AH.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var valueScoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButton: UIButton!
    
    var player: AVAudioPlayer?
    
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
        questionNumber1 += 1
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatwUi), userInfo: nil, repeats: false)
        
        
            
    
        
        
    }
    
    @objc func updatwUi() {
        if questionNumber1 < questionBank.questions.count{
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
        }else{
            showAlert()
        }
       
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "End game ",
                                      message: "play agin ?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel,
                                      handler: { action in
                                        self.start()                                      }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        playSound()
   
        
        
    }
    
    
    
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "clap", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    
    func start() {
        Score = 0
        questionNumber1 = 0
        updatwUi()
    }
}


