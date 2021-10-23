//
//  ViewController.swift
//  TriviaMultipleChoice"Ahmed Alqhtani"
//
//  Created by Ahmed awadh alqhtani on 17/03/1443 AH.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

  @IBOutlet weak var scoreLapel: UILabel!
  
  @IBOutlet weak var questionLable: UILabel!
  
  @IBOutlet weak var firstChoice: UIButton!
  
  @IBOutlet weak var sacendChoice: UIButton!
  
  
  @IBOutlet weak var thirdChoice: UIButton!
  
  
  @IBOutlet weak var fourthChoice: UIButton!
  
  
  @IBOutlet weak var progressBottom: UIProgressView!

  
  var quiz = QuizManager()
  var questionNumber:Int = 0
  var score = 0
  var player: AVAudioPlayer?
  var nextQuestion:Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    questionLable.layer.cornerRadius = 50
    questionLable.layer.borderWidth = 1
    questionLable.layer.masksToBounds = true
    
    firstChoice.layer.cornerRadius = 50
    firstChoice.layer.borderWidth = 1
    firstChoice.layer.masksToBounds = true
    
    sacendChoice.layer.cornerRadius = 50
    sacendChoice.layer.borderWidth = 1
    sacendChoice.layer.masksToBounds = true
    
    thirdChoice.layer.cornerRadius = 50
    thirdChoice.layer.borderWidth = 1
    thirdChoice.layer.masksToBounds = true
    
    fourthChoice.layer.cornerRadius = 50
    fourthChoice.layer.borderWidth = 1
    fourthChoice.layer.masksToBounds = true
    
    updateUI()
    progressBottom.progress = 0.0
    
  }
    
    
    



  
  @IBAction func answerSelected(_ sender: UIButton) {
    let userAnswer = sender.currentTitle!
    let check = quiz.checkAnswer(userAnswer)
    
    if check{
      sender.backgroundColor = UIColor.green
    }
    else {
      sender.backgroundColor = UIColor.red
    }
    
    
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    
    
    if quiz.nextQuestion() {
      
    }
    else {
      showAlert()
    }
  }
  
  
  @objc func updateUI(){
    questionLable.text = quiz.checkQuestion()
    progressBottom.progress = quiz.checkProgress()
    scoreLapel.text = "\(quiz.checkScore())"
    
    
    firstChoice.backgroundColor = UIColor.clear
    sacendChoice.backgroundColor = UIColor.clear
    thirdChoice.backgroundColor = UIColor.clear
    fourthChoice.backgroundColor = UIColor.clear
    
    
    firstChoice.setTitle(quiz.checkChoices()[0], for: .normal);
    sacendChoice.setTitle(quiz.checkChoices()[1], for: .normal)
    thirdChoice.setTitle(quiz.checkChoices()[2], for: .normal)
    fourthChoice.setTitle(quiz.checkChoices()[3], for: .normal)
  }
  
  
  func showAlert() {
    let alert = UIAlertController(title: "End game ",
                                  message: "play agin ?",
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Yes", style: .cancel,
                                  handler: { action in
                                    print("Yes clicked")
                                    self.start()
                                  }))
    
    alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    playSound()
  }
  
  
  func playSound() {
    guard let url = Bundle.main.url(forResource: "clapping", withExtension: "mp3") else { return }
    
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
  
  func start() {
    quiz.start()
    updateUI()
  }
    
    
   
  
 

}

