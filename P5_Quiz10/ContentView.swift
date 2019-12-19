//
//  ContentView.swift
//  P5_Quiz10
//
//  Created by Xinxin Liu on 18/12/2019.
//  Copyright © 2019 Xinxin Liu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
        
    @EnvironmentObject var quizModel: Quiz10Model

    var body: some View {
        NavigationView {
            List{
                ForEach(quizModel.quizzes) { quizItem in
                    NavigationLink(destination:
                    QuizDetail(quizItem: quizItem, quizNum: self.quizModel.quizzes.firstIndex(of: quizItem)!+1)) {
                        QuizRow(quizItem: quizItem)
                    }
                }
            }
            .navigationBarTitle(Text("Quiz Game"))
            .navigationBarItems(trailing: Button(action: {self.quizModel.download()}, label: {Image( "refresh").resizable().frame(width: 20, height: 20).foregroundColor(.black)
            }))
        }
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
