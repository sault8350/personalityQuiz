//
//  Results ViewController.swift
//  personalityQuiz
//
//  Created by Samuel Ault on 3/5/18.
//  Copyright © 2018 John Hersey High School. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    var answerChosen = [Answer]()
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    
    var questionIndex = 0
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
            ]),
        
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
            ]),
        Question(text: "How much do you enjoy car ride?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barley notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)
            ])
    ]
    @IBOutlet weak var singleStackButton1: UIButton!
    @IBOutlet weak var singleStackButton2: UIButton!
    @IBOutlet weak var singleStackButton3: UIButton!
    @IBOutlet weak var singleStackButton4: UIButton!
    
    @IBOutlet weak var multipleStackLabel1: UILabel!
    @IBOutlet weak var multipleStackSwitch1: UISwitch!
    @IBOutlet weak var multipleStackLabel2: UILabel!
    @IBOutlet weak var multipleStackSwitch2: UISwitch!
    @IBOutlet weak var multipleStackLabel3: UILabel!
    @IBOutlet weak var multipleStackSwitch3: UISwitch!
    @IBOutlet weak var multipleStackLabel4: UILabel!
    @IBOutlet weak var multipleStackSwitch4: UISwitch!
    
    @IBOutlet weak var rangeStackHorizontalSlider: UISlider!
    @IBOutlet weak var rangeStackLabel1: UILabel!
    @IBOutlet weak var rangeStackLabel2: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    func updateUI() {
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        
        let totalProgress = Float(questionIndex)/Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        progressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
    }
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultsSegue", sender: nil)
        }
    }
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleStackButton1.setTitle(answers[0].text, for: .normal)
        singleStackButton2.setTitle(answers[0].text, for: .normal)
        singleStackButton3.setTitle(answers[0].text, for: .normal)
        singleStackButton4.setTitle(answers[0].text, for: .normal)
    }
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleStackSwitch1.isOn = false
        multipleStackSwitch2.isOn = false
        multipleStackSwitch3.isOn = false
        multipleStackSwitch4.isOn = false
        multipleStackLabel1.text = answers[0].text
        multipleStackLabel2.text = answers[1].text
        multipleStackLabel3.text = answers[2].text
        multipleStackLabel4.text = answers[3].text
    }
    func updateRangedStack(using answers: [Answer]) {
        rangeStackView.isHidden = false
        rangeStackLabel1.text = answers.first?.text
        rangeStackLabel2.text = answers.last?.text
    
    }
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleStackButton1:
            answerChosen.append(currentAnswers[0])
            
        case singleStackButton2:
            answerChosen.append(currentAnswers[1])
            
        case singleStackButton3:
            answerChosen.append(currentAnswers[2])
            
        case singleStackButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
            
        }
        
        nextQuestion()
    }
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multipleStackSwitch1.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if multipleStackSwitch2.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if multipleStackSwitch3.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if multipleStackSwitch4.isOn {
            answerChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(roundf(rangeStackHorizontalSlider.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegure" {
            let resultsViewController = segue.destination as!
            ResultsViewController
            resultsViewController.responses = answerChosen
        }
    }
    
    
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


