//
//  Menu.swift
//  Milestone-4-6
//
//  Created by Enrico Sousa Gollner on 08/12/22.
//

import SwiftUI

struct Menu: View {
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
    @State var numbQuests: [Int]
    @State var totalQuestion: Int
    
    var body: some View {
       
    }
}
