//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by Oliver Gepp on 24.07.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
        
    var body: some View {
        VStack{
            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeOut(duration: 0.75)){
                        viewModel.choose(card: card)
                    }
                    
                }.padding(5)
            }
            
            Button(action: {
                withAnimation(.easeInOut){
                    viewModel.resetGame()}
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct CardView: View{
    
    var card: MemoryGameModel<String>.Card
    
    var body: some View{
        GeometryReader{geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize)-> some View{
        ZStack{
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).foregroundColor(.blue)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            }
            else{
                if !card.isMatched{
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.orange)
                }
            }
            
        }.aspectRatio(0.75, contentMode: .fit).padding()
        .rotation3DEffect(Angle.degrees( card.isFaceUp ? 0 : 180 ),axis:(0,1,0))
    }
    
    
    // MARK: - Drawing Constants
    let cornerRadius = CGFloat(10)
    let edgeLineWidth = CGFloat(3)
    func fontSize(for size: CGSize)->CGFloat{
        min(size.width, size.height)*0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
    }
}
