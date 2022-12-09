    //
    //  ContentView.swift
    //  Milestone-4-6
    //
    //  Created by Enrico Sousa Gollner on 07/12/22.
    //

    import SwiftUI

struct ContentView: View {
    @State private var isRunning = false

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

    @State private var isEmpty = false

    @State private var animationAmount = 1.0
    
    @State private var isTapped = false
    @State private var isTappedAux = 1

    @State private var animationRotate = 0.0
    
    var body: some View{
        NavigationStack{
            VStack(spacing: 40){
                
                if !isRunning{
                    
                    Text("Wich table you feel like practicing today")
                        .font(.headline)
                    
                    VStack{
                        Text("Selected:")
                        Text("\(multiTable)")
                            .padding(20)
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                        
                    
                    HStack(){
                        ForEach(2..<11){ num in
                            Button("\(num)"){
                                multiTable = num
                                isTappedAux = num
                            }
                            .padding(10)
                            .background(num == isTappedAux ? .blue.opacity(0.8) : .blue)
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
                        .overlay(
                            Circle()
                                .stroke(.blue)
                                .scaleEffect(animationAmount)
                                .opacity(2 - animationAmount)
                                .animation(.easeInOut(duration: 1)
                                    .repeatForever(autoreverses: false), value: animationAmount)
                        )
                        .onAppear{
                            animationAmount = 2.0
                        }
                        
                    }
                } else{
                    VStack(spacing: 20){
                        Spacer()
                        
                        Text("Question \(quest)")
                            .font(.headline)
                        
                        
                        Text("\(multiTable) x \(multiNum)")
                            .padding(10)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .rotation3DEffect(.degrees(animationRotate), axis: (x: 1, y: 0, z: 0))
                            
                        
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
                        if isEmpty{
                            Button("Ok"){
                                isEmpty = false
                            }
                        } else{
                            Button("Yes"){
                                askQuest()
                            }
                            Button("No"){
                                isRunning = false
                            }
                        }
                    } message: {
                        Text(alertMsg)
                    }
                    .alert("Game over", isPresented: $isOver){
                        Button("Restart"){
                            isRunning = false
                            quest = 0
                            score = 0
                        }
                    } message: {
                        Text("Your final score is: \(score)")
                    }
                }
                
            }
            .ignoresSafeArea()
            .navigationTitle("Practicing tables")
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        answerTryisFocused = false
                        check(answerTry)
                        answerTry = ""
                    }
                }
            }
        }
    }

    func check(_ answerTry: String){
        
        var answer = 0
        
        let numTry = Int(answerTry.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        
        if answerTry.count == 0{
            isEmpty = true
            showAlert(title: "It's empty", msg: "Try with a number! \nYou can do that.")
        } else{
            answer = multiNum * multiTable
            
            if answer == numTry{
                showAlert(title: "Correct!", msg: "Congratulations!\nWant to try again?")
                score += 1
            } else{
                showAlert(title: "Wrong", msg: "Answer: \(answer)\nWant to try in the next one?")
            }
            
            if quest == totalQuestion{
                isOver = true
            }
        }
    }

    func askQuest(){
        quest += 1
        
        withAnimation{
            animationRotate += 360
        }
        
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
