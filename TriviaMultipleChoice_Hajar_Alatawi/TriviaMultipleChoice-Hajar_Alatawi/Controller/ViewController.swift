

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  
  @IBOutlet weak var titleScoreLabel: UILabel!
  @IBOutlet weak var valueScoreLabel: UILabel!
  
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var optionFirstButton: UIButton!
  @IBOutlet weak var optionSeconedButton: UIButton!
  @IBOutlet weak var optionThirdButton: UIButton!
  @IBOutlet weak var optionFourthButton: UIButton!
  
  @IBOutlet weak var progressBar: UIProgressView!
  
  
  internal var quiz : QuizBrain = QuizBrain ()
  private var score = 0
  private var player: AVAudioPlayer?
  
  
  override func viewDidLoad () {
    
    super.viewDidLoad ()
    configureButtons ()
    progressBar.progress = 0
    titleScoreLabel.text = "Score:"
    valueScoreLabel.text = "\(score)"
    updateScreen ()
  }
  
  
  @IBAction func answerButtonPressed(_ sender: UIButton) {
    
    let playerAnswer = sender.currentTitle!
    let isCorrect = quiz.getTheAnswer(playerAnswer)
    
    if isCorrect {
      sender.backgroundColor = UIColor.green
      playRightAnswerSound ()
    }
    
    else {
      sender.backgroundColor = UIColor.red
      playWrongAnswerSound ()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
      sender.backgroundColor = UIColor.clear
    })
    
    if quiz.nextQuestion () {
      
      updateScreen()
      
      if quiz.questionNumber == quiz.questions.count {
        if quiz.hasUserGoodScore () {
          playHighScoreSound ()
        }
        
        let alert = UIAlertController(title: "QUIZ IS DONE!",
                                      message: "You did a great job 🥳👏🏻 \n your score is \(quiz.getTheScore()) / 25",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Quit the quiz", style: .default, handler:  { (action:UIAlertAction!) -> Void in
          
          //after user press "quit the quiz", the app will quit or exit
          exit(0)
        }))
        
        self.present(alert, animated: true)
      }
    }
  }
  
  
  func updateScreen () {
    
    progressBar.progress = quiz.getTheProgress ()
    
    if quiz.questionNumber < quiz.questions.count {
      questionLabel.text = quiz.getTheQuestion ()
    }
    
    questionLabel.text = quiz.getTheQuestion ()
    progressBar.progress = quiz.getTheProgress ()
    valueScoreLabel.text = "\(quiz.getTheScore ())"
    
    let answers = quiz.getAnswers ()
    
    optionFirstButton.setTitle(answers [0], for: .normal)
    optionSeconedButton.setTitle(answers [1], for: .normal)
    optionThirdButton.setTitle(answers [2], for: .normal)
    optionFourthButton.setTitle(answers [3], for: .normal)
  }
  
  
  func configureButtons () {
    
    optionFirstButton.layer.cornerRadius = 30
    optionFirstButton.layer.borderWidth = 3
    optionFirstButton.layer.borderColor = UIColor.white.cgColor
    
    optionSeconedButton.layer.cornerRadius = 30
    optionSeconedButton.layer.borderWidth = 3
    optionSeconedButton.layer.borderColor = UIColor.white.cgColor
    
    optionThirdButton.layer.cornerRadius = 30
    optionThirdButton.layer.borderWidth = 3
    optionThirdButton.layer.borderColor = UIColor.white.cgColor
    
    optionFourthButton.layer.cornerRadius = 30
    optionFourthButton.layer.borderWidth = 3
    optionFourthButton.layer.borderColor = UIColor.white.cgColor
  }
  
  
  func playRightAnswerSound () {
    
    guard let url = Bundle.main.url(forResource: "Right_Answer",
                                    withExtension: "mp3") else { return }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else { return }
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  func playWrongAnswerSound () {
    
    guard let url = Bundle.main.url(forResource: "Wrong_Answer",
                                    withExtension: "mp3") else { return }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else { return }
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  func playHighScoreSound () {
    
    guard let url = Bundle.main.url(forResource: "Crowd_sound",
                                    withExtension: "mp3") else { return }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else { return }
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
}


