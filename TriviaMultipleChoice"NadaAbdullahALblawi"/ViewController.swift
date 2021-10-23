//
//  ViewController.swift
//  TriviaMultipleChoice"NadaAbdullahALblawi"
//
//  Created by apple on 17/03/1443 AH.
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
    
    private var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButons()
        update()
        questionLabel.text = viewModel.question.question
    }
    
    func configureButons() {
        optionFirstButton.layer.cornerRadius = 20
        optionFirstButton.layer.borderWidth = 3
        optionFirstButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
        optionSecondButton.layer.cornerRadius = 20
        optionSecondButton.layer.borderWidth = 3
        optionSecondButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
        optionThirdButton.layer.cornerRadius = 20
        optionThirdButton.layer.borderWidth = 3
        optionThirdButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
        optionFourthButton.layer.cornerRadius = 20
        optionFourthButton.layer.borderWidth = 3
        optionFourthButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    }
    
    func startOver(_ action: UIAlertAction) {
        viewModel.score = 0
        viewModel.currentQuestionIndex = 0
        update()
    }
    
    func update() {
        questionLabel.text = viewModel.question.question
        optionFirstButton.setTitle(viewModel.question.answers[0], for: .normal)
        optionSecondButton.setTitle(viewModel.question.answers[1], for: .normal)
        optionThirdButton.setTitle(viewModel.question.answers[2], for: .normal)
        optionFourthButton.setTitle(viewModel.question.answers[3], for: .normal)
        valueScoreLabel.text = "\(viewModel.score)"
        let total = Float(Float(viewModel.currentQuestionIndex + 1) /  Float(viewModel.questions.count)) * 100.0
        print(total)
        print(total * 0.01)
        progressBar.progress = total * 0.01
        
    }
    
    func nextQuestion() {
        if viewModel.currentQuestionIndex < viewModel.questions.count-1 {
            viewModel.currentQuestionIndex += 1
            update()
        } else {
            let alert = UIAlertController(title: "Done",
                                          message: "",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Start Again", style: .default, handler: self.startOver))
            self.present(alert, animated: true)
        }
        enableAll()
    }
    
    func disableAll() {
        optionFirstButton.isEnabled = false
        optionSecondButton.isEnabled = false
        optionThirdButton.isEnabled = false
        optionFourthButton.isEnabled = false
    }
    
    func enableAll() {
        optionFirstButton.isEnabled = true
        optionSecondButton.isEnabled = true
        optionThirdButton.isEnabled = true
        optionFourthButton.isEnabled = true
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        disableAll()
        if viewModel.check(tag: sender.tag) {
            sender.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                sender.backgroundColor = .clear
                self.nextQuestion()
            }
        } else {
            sender.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                sender.backgroundColor = .clear
                self.nextQuestion()
            }
        }
    }
    
}

