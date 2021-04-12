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
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var feedback = UINotificationFeedbackGenerator()
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
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
                .onChanged{ offset in
                    self.offset = offset.translation
                    self.feedback.prepare()
                }
                .onEnded{ _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width > 0 {
                            //shouldn't be used too much. Failure Haptic should be kept and Success Haptic removed for better user experience 
                            self.feedback.notificationOccurred(.success)
                        } else {
                            self.feedback.notificationOccurred(.error)
                        }
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
