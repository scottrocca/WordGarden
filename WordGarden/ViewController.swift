// 
//  ViewController.swift
//  WordGarden
//
//  Created by Scott Rocca on 7/4/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsInGameLabel: UILabel!
    
    
    @IBOutlet weak var wordBeingRevealedLabel: UILabel!
    @IBOutlet weak var guessedLetterTextField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var gameStatusMessageLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    let wordsToGuess = ["SWIFT", "DOG", "CAT"]
    var currentWordIndex = 0
    var wordToGuess = ""
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessLetterButton.isEnabled = !(guessedLetterTextField.text!.isEmpty)
        wordToGuess = wordsToGuess[currentWordIndex]
        wordBeingRevealedLabel.text = "_" + String(repeating: " _", count: wordToGuess.count-1)
        
//        var revealedWord = "_"
//        for _ in 1...wordToGuess.count - 1 {
//            revealedWord = revealedWord + " _"
//        }
//        wordBeingRevealedLabel.text = revealedWord
        

    }
    
    func updateUIAfterGuess() {
        //This dismisses the keyboard
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = ""
        guessLetterButton.isEnabled = false
    }
    
    func formatRevealWord() {
        var revealedWord = ""
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + "\(letter)"
            } else {
                revealedWord = revealedWord + "_ "
            }
        }
        //remove the extra space at the end of revealedWord
        if revealedWord.hasSuffix(" ") {
            revealedWord.removeLast()
        }
        
        wordBeingRevealedLabel.text = revealedWord
    }
    
    func guessALetter() {
        let currentLetterGuessed = guessedLetterTextField.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed
        
        formatRevealWord()
        
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        sender.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces)
        guessLetterButton.isEnabled = !(sender.text!.isEmpty)
    }
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
    }
    
}

