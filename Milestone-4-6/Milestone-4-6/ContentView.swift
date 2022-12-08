//
//  ContentView.swift
//  Milestone-4-6
//
//  Created by Enrico Sousa Gollner on 07/12/22.
//

import SwiftUI

struct Play: View{
    @State var quest: Int
    @State var multiNum: Int
    @State var multiTable: Int
    @State var answerTry: String
    @FocusState var answerTryisFocused
    @State var score: Int
    @State var alertTitle: String
    @State var alertMsg: String
    @State var showingAlert: Bool
    @State var isRunning: Bool
    @State var askQuest: () -> ()
    @State var isOver: Bool
    
    
    var body: some View{
        VStack(spacing: 20){
            Spacer()
            Spacer()
            
            Text("Question \(quest)")
                .font(.headline)
            
            Text("\(multiNum) x \(multiTable)")
                .font(.largeTitle)
            
            Spacer()
            
            HStack{
                TextField("Answer", text: $answerTry)
                    .padding(20)
                    .keyboardType(.decimalPad)
                    .focused($answerTryisFocused)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(20)
            Spacer()
            
            Text("Score: \(score)")
            
            Spacer()
        }
        .alert(alertTitle, isPresented: $showingAlert){
            Button("Yes"){
                askQuest()
            }
            Button("No"){
                isRunning = false
            }
        } message: {
            Text(alertMsg)
        }
        .alert("Game over", isPresented: $isOver){
            Button("Restart"){
                isRunning = false
            }
        } message: {
            Text("Your final score is: \(score)")
        }
    }
    
    
}


struct ContentView: View {
    @State private var isRunning = false
    
    @State private var isTapped = false
    
    @State private var multiTable = 2
    
    @State private var multiNum = Int.random(in: 1...10)
    
    @State private var totalQuestion = 5
    let numbQuests = [5, 10, 20]
    
    @State private var quest = 1
    
    @State private var answerTry = ""
    @FocusState private var answerTryisFocused: Bool
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    @State private var score = 0
    
    @State private var isOver = false
    
    var body: some View{
        NavigationStack{
            VStack(spacing: 40){
                
                if !isRunning{
                    
                    Text("Wich table you feel like practicing today")
                        .font(.headline)
                    
                    Text("\(multiTable)")
                    
                    HStack(){
                        ForEach(2..<11){ num in
                            Button("\(num)"){
                                multiTable = num
                            }
                            .padding(10)
                            .background(isTapped ? .blue.opacity(0.7) : .blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                    VStack{
                        Text("Now, select the number of questions you want")
                            .font(.headline)
                        
                        Picker("Select a number of levels", selection: $totalQuestion){
                            ForEach(numbQuests, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                    .transition(.scale)
                    
                    if !isRunning{
                        Button("Play"){
                            withAnimation{
                                isRunning.toggle()
                            }
                        }
                        .padding(30)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .transition(.scale)
                    }
                } else{
                    Play(quest: quest, multiNum: multiNum, multiTable: multiTable, answerTry: answerTry, score: score, alertTitle: alertTitle, alertMsg: alertMsg, showingAlert: showingAlert, isRunning: isRunning, askQuest: askQuest, isOver: isOver)
                }
                
            }
            .background(.white)
            .ignoresSafeArea()
            .navigationTitle("Practicing tables")
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        answerTryisFocused = false
                        
                        check(Int(answerTry.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0)
                        answerTry = ""
                    }
                }
            }
        }
    }
    
    func check(_ numTry: Int){
        if quest == totalQuestion{
            isOver = true
        } else{
            let answer = multiNum * multiTable
            
            if answer == numTry{
                showAlert(title: "Correct!", msg: "Congratulations!\nWant to try again?")
            } else{
                showAlert(title: "Wrong!", msg: "Oh, you can do it!\nWant to try again?")
            }
        }
    }
    
    func askQuest(){
        quest += 1
        
        if quest > totalQuestion{
            isOver = true
        } else{
            multiNum = Int.random(in: 1...10)
        }
        
    }
    
    func showAlert(title: String, msg: String){
        alertTitle = title
        alertMsg = msg
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
