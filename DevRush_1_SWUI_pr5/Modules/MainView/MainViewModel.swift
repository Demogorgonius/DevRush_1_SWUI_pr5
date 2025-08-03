//
//  MainViewModel.swift
//  DevRush_1_SWUI_pr5
//
//  Created by Sergey on 03.08.2025.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
  
    @Published  var usedWords = [String]()
    @Published  var rootWord: String = ""
    @Published  var newWord: String = ""
    
    @Published  var errorTitle = ""
    @Published  var errorMessage = ""
    @Published  var showingError = false
 
    func addNewWord() {
        
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginalWord(word: answer) else {
            wordErrorMessage(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordErrorMessage(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordErrorMessage(title: "Word not recognized", message: "You can't just make then up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
        
    }
    
    func startGame() {
        
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL, encoding: .windowsCP1251) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
        
    }
    
    func isOriginalWord(word: String) -> Bool {
        
        !usedWords.contains(word)
        
    }
    
    func isPossible(word: String) -> Bool {
        
        var tempWord = rootWord
        
        for char in word {
            
            if let pos = tempWord.firstIndex(of: char) {
                
                tempWord.remove(at: pos)
                
            } else {
                
                return false
                
            }
            
        }
        
        return true
        
    }
    
    
    func isRealWord(word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
        
    }
    
    func wordErrorMessage(title: String, message: String) {
        
        errorTitle = title
        errorMessage = message
        showingError = true
        
    }
    
}
