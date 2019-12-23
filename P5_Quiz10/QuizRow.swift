//
//  QuizRow.swift
//  P5_Quiz10
//
//  Created by Xinxin Liu on 18/12/2019.
//  Copyright © 2019 Xinxin Liu. All rights reserved.
//

import SwiftUI

struct QuizRow: View {
    
    var quizItem: QuizItem
    var favourite: Bool = false

    @EnvironmentObject var imageStore: ImageStore
    
    var body: some View {
        HStack {
            ZStack (alignment: .bottomTrailing){
                Image(uiImage: self.imageStore.image(url: quizItem.attachment?.url))
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 75)
                .clipped()
                .cornerRadius(75)
                //.padding(.all, 5)
                
                Image((favourite ? "heart1" : "")).resizable().frame(width: 20, height: 20).offset(x: 5, y: 5)
                
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
        }
    }
}
