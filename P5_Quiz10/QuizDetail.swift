//
//  QuizDetail.swift
//  P5_Quiz10
//
//  Created by Xinxin Liu on 18/12/2019.
//  Copyright © 2019 Xinxin Liu. All rights reserved.
//

import SwiftUI

struct QuizDetail: View {
    
    var quizItem: QuizItem
    var quizNum: Int

    @State var answer: String = ""
    @State var showAlert = false
    @State var msg: String = ""
    
    var alert: Alert {
        Alert(title: Text("Result"), message: Text(msg), dismissButton: .default(Text("OK")))
    }
    
    @EnvironmentObject var imageStore: ImageStore
    
    var body: some View {
        VStack (alignment: .leading) {
            Spacer()
            Image(uiImage: self.imageStore.image(url: quizItem.attachment?.url))
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity,  alignment: Alignment.topLeading)
                .aspectRatio(1.1, contentMode: .fit)
                .clipped()
                .cornerRadius(10)
            HStack {
                Text("Question number \(quizNum)").fontWeight(.bold).font(.body)
                    .padding(.leading, 15)
                    .padding(.top, 7)
            }
            Spacer()
            
            Text(quizItem.question)
            .font(.title)
            .padding(.leading, 15)
            
            Spacer()

            VStack {
                TextField("Your Answer", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.horizontal, 10)
                Button(action: {self.checkAnswer()}) {
                    HStack {
                        Text("Check Answer")
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundColor(.white)
                .background(Color(red: 10 / 255, green: 175 / 255, blue: 212 / 255))
                .cornerRadius(5)
                .padding(.horizontal, 10)
            }
            HStack {
                Spacer()
                Image(uiImage: self.imageStore.image(url: quizItem.author?.photo?.url))
                .resizable()
                .scaledToFill()
                .clipped()
                .clipShape(Circle())
                .frame(width: 25, height: 25)
                Text("Created by \(quizItem.author!.username)")
                    .font(.caption).padding(.trailing, 10)
            }
            
        }
        .padding(.horizontal, 15)
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showAlert, content: {self.alert})
        
    }
    func checkAnswer() {
        if answer.lowercased() == quizItem.answer.lowercased() {
            print("Bien")
            msg = "Correct Answer!"
        } else {
            print("Mal")
            msg = "Wrong Answer!"
        }
        self.showAlert.toggle()

    }

}

