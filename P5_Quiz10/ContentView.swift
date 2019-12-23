//
//  ContentView.swift
//  P5_Quiz10
//
//  Created by Xinxin Liu on 18/12/2019.
//  Copyright © 2019 Xinxin Liu. All rights reserved.
//

import SwiftUI

private let defaults = UserDefaults.standard

struct ContentView: View {
        
    @State var score: [Int] = [Int]()

    @EnvironmentObject var imageStore: ImageStore
    @EnvironmentObject var quizModel: Quiz10Model

    var body: some View {
        
        let bindingScore = Binding(
            get: {self.score},
            set: {
                defaults.set($0, forKey: "score")
                self.score = $0
            }
        )
        
        return NavigationView {
            List{
                ForEach(quizModel.quizzes) { quizItem in
                    NavigationLink(destination:
                    QuizDetail(quizItem: quizItem, quizNum: self.quizModel.quizzes.firstIndex(of: quizItem)!+1, score: bindingScore)) {
                        HStack {
                            ZStack (alignment: .bottomTrailing){
                                Image(uiImage: self.imageStore.image(url: quizItem.attachment?.url))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipped()
                                .cornerRadius(75)
                                //.padding(.all, 5)
                                
                                Image((quizItem.favourite ? "heart1" : "")).resizable().frame(width: 20, height: 20).offset(x: 5, y: 5)
                                
                            }
                            //.shadow(radius: 5) //no lo pongo porque si la imagen que ha subido tiene fondo trasparente se ve mal
                            .padding(.trailing, 10)
                            //.padding(.vertical, 5)
                            VStack (alignment: .leading){
                                Spacer()
                                HStack {
                                    Text(quizItem.question)
                                        .font(.headline)
                                }
                                Spacer()
                                HStack {
                                    Text("Created by \(quizItem.author!.username)")
                                        .font(.caption)
                                    Spacer()
                                    Image(uiImage: self.imageStore.image(url: quizItem.author?.photo?.url))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .clipShape(Circle())
                                    .frame(width: 25, height: 25)
                                }
                            }
                        }                    }
                }
            }
            .navigationBarTitle(Text("Quiz Game"))
            .navigationBarItems(trailing:
                HStack {
                    Text("Score: \(score.count)").font(.caption).foregroundColor(.gray)
                    Button(action: {self.quizModel.download()}, label: {
                        Image("refresh").resizable().frame(width: 20, height: 20).foregroundColor(.black)
                    })
                }
            )
            
        }
        .onAppear(perform: {
            self.score = defaults.object(forKey: "score") as? [Int] ?? []
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct ContentView_Previews: PreviewProvider {
//
//    static var quizModel: Quiz10Model = {
//        let qm = Quiz10Model()
//        qm.download()
//        return qm
//    }()
//
//    static var previews: some View {
//        ContentView()
//        .environmentObject(quizModel)
//    }
//}
