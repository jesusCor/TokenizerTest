//
//  LanguageManager.swift
//  TokenizerTest
//
//  Created by Jesus Coronado on 05/01/2024.
//

import Foundation


enum LanguageOption {
    case english, spanish
    
    var outputLabel: String {
        switch self {
        case .english:
            return "English"
        case .spanish:
            return "Spanish"
        }
    }
}


// We’ll apply the Singleton pattern and we’ll be using one instance only, the shared instance.
class LanguageManager: NSObject {
    
    static let shared = LanguageManager()
    private override init() {
        super.init()
    }
    
    
    func detectLanguage(text: String) -> LanguageOption {
        // Simple language detection logic - range(of:) does a case-sensitive search by default.
        // We don't use if let... because we have a multiple OR condition (not AND).
        let spanishRange1 = text.range(of: "and", options: .caseInsensitive)
        let spanishRange2 = text.range(of: "if", options: .caseInsensitive)
        
        if (spanishRange1 != nil || spanishRange2 != nil) {
            return .english
        } else {
            return .spanish
        }
    }
    
}
