//
//  ContentView.swift
//  DevRush_1_SWUI_pr5
//
//  Created by Sergey on 02.08.2025.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mainVM: MainViewModel
    
    @State private var newWord: String = ""
    
    private var textFldLabel: LocalizedStringKey = LocalizedStringKey("textFieldLabel")
    
    init(mainVM: MainViewModel) {
        self.mainVM = mainVM
    }
    
    var body: some View {

        NavigationStack {
            List {
                
                Section {
                    TextField(textFldLabel, text: $mainVM.newWord)
                }
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)
                .onSubmit(mainVM.addNewWord)
                .onAppear(perform: mainVM.startGame)
                
                .alert(mainVM.errorTitle, isPresented: $mainVM.showingError) {} message: {
                    Text(mainVM.errorMessage)
                }
                
                .navigationTitle($mainVM.rootWord)
                Section {
                    
                    ForEach(mainVM.usedWords, id: \.self) { word in
                       
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
}

#Preview {
    ContentView(mainVM: MainViewModel())
}
