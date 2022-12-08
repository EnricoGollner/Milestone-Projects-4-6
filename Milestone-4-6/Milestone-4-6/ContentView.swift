//
//  ContentView.swift
//  Milestone-4-6
//
//  Created by Enrico Sousa Gollner on 07/12/22.
//

import SwiftUI

struct Menu: View{
    @State var isRunning = false
    
    @State private var multiTable = 2
    @State private var numbQuestion = 5
    let numbQuests = [5, 10, 20]
    
    var body: some View{
        NavigationStack{
            VStack(spacing: 40){
                ZStack{
                    Color.blue
                        .frame(height: 150)
                }
                
                Text("Wich table you feel like practicing today")
                    .font(.headline)
                
                HStack(){
                    ForEach(1..<11){
                        Button("\($0)"){
                            
                        }
                        .padding(10)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                VStack{
                    Text("Now, select the number of questions you want")
                        .font(.headline)
                    
                    Picker("Select a number of levels", selection: $numbQuestion){
                        ForEach(numbQuests, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                
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
                
                Spacer()
            }
            .ignoresSafeArea()
            .navigationTitle("Practicing tables")
        }
    }
}

struct ContentView: View {
    var body: some View {
       Menu()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
