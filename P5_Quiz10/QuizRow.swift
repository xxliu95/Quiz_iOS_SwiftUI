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
    
    @EnvironmentObject var imageStore: ImageStore
    
    var body: some View {
        HStack {
            ZStack {
                Image(uiImage: self.imageStore.image(url: quizItem.attachment?.url))
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 75)
                .clipped()
                .cornerRadius(10)
            }
            //.shadow(radius: 5) //no lo pongo porque si la imagen que ha subido tiene fondo trasparente se ve mal
            .padding(.trailing, 20)
            .padding(.vertical, 5)
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
