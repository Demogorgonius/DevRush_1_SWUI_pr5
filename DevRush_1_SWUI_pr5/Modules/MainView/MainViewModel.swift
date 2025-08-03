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
 
    func addNewWord() {
        
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        usedWords.insert(answer, at: 0)
        newWord = ""
        
    }
    
}
