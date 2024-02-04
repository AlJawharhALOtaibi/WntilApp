//
//  SplashPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 10/07/1445 AH.
//  Almost Completed: Need a Gif


import SwiftUI

struct SplashView: View {
    @State private var isAnimationFinished = false
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
        
                Image("Fairy")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                isAnimationFinished = true
                            }
                        }
            }
        }
    }
}

