//
//  TokenizerVC.swift
//  TokenizerTest
//
//  Created by Jesus Coronado on 05/01/2024.
//

import UIKit


class TokenizerVC: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var tokenizeButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    
    
    // MARK: VC Lifecycle functions.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI configuration.
        setupUI()
        
        // Delegates configuration.
        inputTextView.delegate = self
        
        // Gesture to dismiss keyboard when clicking away.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    // MARK: Styling functions.

    func setupUI() {
        view.backgroundColor = UIColor.lightGray
        
        inputTextView.layer.borderColor = UIColor.black.cgColor
        inputTextView.layer.borderWidth = 1.0
        inputTextView.layer.cornerRadius = 5.0
        outputTextView.layer.borderColor = UIColor.black.cgColor
        outputTextView.layer.borderWidth = 1.0
        outputTextView.layer.cornerRadius = 5.0
        tokenizeButton.layer.cornerRadius = 8
    }
    
    
    // MARK: IBAction functions.
    
    
    @IBAction func tokenizeButtonClicked(_ sender: Any) {
        // Guard against the text entered being empty.
        guard let text = inputTextView.text, !text.isEmpty else {
            outputTextView.text = "Please enter a sentence first!"
            return
        }

        // Detect language first and tokenize it afterwards.
        let language = LanguageManager.shared.detectLanguage(text: text)
        let tokens = tokenize(sentence: text, language: language)

        // Display the result.
        outputTextView.text = "LANGUAGE:\n \(language.outputLabel)\n\nTOKENIZATION:\n \(tokens.joined(separator: "\n"))"
        dismissKeyboard()
    }
    
    
    // MARK: Language functions.

    func tokenize(sentence: String, language: LanguageOption) -> [String] {
        // We'll use every single case to make it non case-insensitive.
        let keywordMap: [LanguageOption: [String]] = [
            .english: ["if", "and", "If", "And"],
            .spanish: ["si", "y", "Si", "Y"]
        ]

        guard let keywords = keywordMap[language] else {
            return []
        }

        var tokens: [String] = []
        tokens += sentence.components(separatedBy: keywords)

        return tokens.filter { !$0.isEmpty }
    }
    
    
    // MARK: Additional functions.
    
    @objc func dismissKeyboard(){
         view.endEditing(true)
    }

}


// MARK: VC extensions.

extension TokenizerVC: UITextViewDelegate {
    // Used to dismiss keyboard when clicking on return.
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            dismissKeyboard()
            return false
        } else {
            return true
        }
    }
}


