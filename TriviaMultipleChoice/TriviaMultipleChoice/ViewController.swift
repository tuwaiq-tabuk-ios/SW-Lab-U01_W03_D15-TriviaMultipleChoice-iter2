//
//  ViewController.swift
//  TriviaMultipleChoice
//
//  Created by azooz alhwiti on 18/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var valueScoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    
    var score:Float = 0.0
    var allQuestion = QuestionBank().getQuestions()
    var numberQuestion:Int = 0
    var correctAnswer:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        updateQuestion()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle == correctAnswer {
            print("Correct")
            score += 5
            sender.backgroundColor = .systemGreen
        }else{
            print("Incorrect")
            score -= 10
            sender.backgroundColor = .systemRed

        }
        numberQuestion += 1
        next()
    }
    
    func next() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateQuestion), userInfo: nil, repeats: false)
    }
    
   @objc func updateQuestion() {
        if numberQuestion < allQuestion.count {
            questionLabel.text = allQuestion[numberQuestion].question
            optionFirstButton.setTitle(allQuestion[numberQuestion].answers[0], for: .normal)
            optionSecondButton.setTitle(allQuestion[numberQuestion].answers[1], for: .normal)
            optionThirdButton.setTitle(allQuestion[numberQuestion].answers[2], for: .normal)
            optionFourthButton.setTitle(allQuestion[numberQuestion].answers[3], for: .normal)
            correctAnswer = allQuestion[numberQuestion].correctAnswer
            updateUI()
        }else{
            let alert = UIAlertController.init(title: "Game Over", message: "Do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction.init(title: "restart", style: .default) { action in
                self.restart()
            }
            playSound()
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func restart() {
        score = 0
        numberQuestion = 0
        updateQuestion()
    }
    
    
    func updateUI() {
        valueScoreLabel.text = "\(Int(score))"
        progressBar.progress = Float(Float(numberQuestion) / Float(allQuestion.count))
        optionFirstButton.backgroundColor = .clear
        optionSecondButton.backgroundColor = .clear
        optionThirdButton.backgroundColor = .clear
        optionFourthButton.backgroundColor = .clear
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "clap", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

