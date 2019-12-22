//
//  QuizDetail.swift
//  P5_Quiz10
//
//  Created by Xinxin Liu on 18/12/2019.
//  Copyright © 2019 Xinxin Liu. All rights reserved.
//

import SwiftUI

struct QuizDetail: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var quizItem: QuizItem
    var quizNum: Int

    @Binding var score: [Int]
    
    @State var answer: String = ""
    @State var showAlert = false
    @State var msg: String = ""
    
    var alert: Alert {
        Alert(title: Text("Result"), message: Text(msg), dismissButton: .default(Text("OK")))
    }
    
    @EnvironmentObject var imageStore: ImageStore
    
    var body: some View {
        
        ZStack {
            if horizontalSizeClass == .compact {
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
                        Text("Score: \(score.count)").font(.caption).foregroundColor(.gray).padding(.leading, 15)
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

            } else {
                HStack {
                    VStack (alignment: .leading){
                        VStack (alignment: .leading){
                            
                            Text("Question number \(quizNum)").fontWeight(.bold).font(.body)
                            .padding(.leading, 15)
                            .padding(.top, 7)
                            
                            Spacer()
                            Text(quizItem.question)
                            .font(.title)
                            .padding(.leading, 15)
                            Spacer()
                        }
                        VStack (alignment: .leading){
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
                            
                            Image(uiImage: self.imageStore.image(url: quizItem.author?.photo?.url))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .clipShape(Circle())
                            .frame(width: 25, height: 25)
                            Text("Created by \(quizItem.author!.username)")
                                .font(.caption).padding(.trailing, 10)
                            Spacer()
                            
                            Text("Score: \(score.count)").font(.caption).foregroundColor(.gray).padding(.trailing, 15)
                        }
                        .padding(.top, 10)

                    }
                    .padding(.trailing, 25)
                    
                    VStack {
                        Image(uiImage: self.imageStore.image(url: quizItem.attachment?.url))
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity,  alignment: Alignment.topLeading)
                        .aspectRatio(1.1, contentMode: .fit)
                        .clipped()
                        .cornerRadius(10)
                    
                    }
                }
                .padding(.vertical, 15)
                .alert(isPresented: $showAlert, content: {self.alert})
                
            }
        }
//        .navigationBarItems(trailing:
//            Button(action: {self.quizModel.download()}, label: {
//                Image(\(quizItem.favourite ? "Heart1" : "Heart0")).resizable().frame(width: 20, height: 20).foregroundColor(.black)
//            })
            
        )
    }
    func checkAnswer() {
        if answer.lowercased() == quizItem.answer.lowercased() {
            var scoreSet = Set(self.score)
            scoreSet.insert(quizItem.id)
            self.score = Array(scoreSet)
            print("Bien")
            msg = "Correct Answer!"
        } else {
            print("Mal")
            msg = "Wrong Answer!"
        }
        self.showAlert.toggle()

    }

//    func toggleFavourite() {
//        let config = URLSessionConfiguration.default
//        let session = URLSEssion(configuration: config)
//        let url = URL(string: "https://quiz.dit.upm.es/api/users/tokenOwner/favourites/quizId?token=8606ca3284a0e9615d99")
//        var request = URLRequest(url: url)
//        if self.quizItem.favourite {
//            request.httpMethod = "DELETE"
//        } else {
//            request.httpMethod = "PUT"
//        }
//
//        let task = session.dataTaskWithRequest(request) {
//            (data, response, error) -> Void in
//
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//
//            let code = (res as! HTTPURLResponse).statusCode
//            if code == 200 {
//                print("Subido")
//            } else {
//                print("HTTP status code \(code)")
//            }
//        }
//    }
}
