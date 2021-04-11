//
//  CardView.swift
//  Flashzilla
//
//  Created by Raj Malhotra on 10.04.21.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    @State private var offset = CGSize.zero
    @State private var isShowingAnswer = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack{
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
               
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .opacity(2 - Double(abs(offset.width / 50)))
        .offset(x: offset.width * 5, y: 0)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    self.offset = gesture.translation
                }
                .onEnded{ _ in
                    if abs(self.offset.width) > 100 {
                        self.removal?()
                    } else{
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}