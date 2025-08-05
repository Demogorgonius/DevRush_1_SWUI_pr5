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
            VStack {
                HStack {
                    
                    Spacer(minLength: 10)
                    
                    Image(systemName: "medal.star.fill")
                    Text(String(mainVM.hightScore))
                    Spacer()
                    
                    Button {
                        mainVM.startGame()
                    } label: {
                        Text(LocalizedStringKey("buttonTitle"))
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    
                    Spacer()
                    Image(systemName: "clock")
                    Text(String(mainVM.currentScore))
                    
                    Spacer(minLength: 10)
                    
                }

            }
            
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
                
                
                
                Section {
                    
                    ForEach(mainVM.usedWords, id: \.self) { word in
                       
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                    
                }
                
            }
            .navigationTitle($mainVM.rootWord)
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    ContentView(mainVM: MainViewModel())
}
