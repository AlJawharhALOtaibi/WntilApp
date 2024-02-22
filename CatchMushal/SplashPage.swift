//
//  SplashPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 10/07/1445 AH.
//  Almost Completed: Need a Gif

import SwiftUI

struct SplashView: View {
    @State private var isAnimating = false
    var completion: () -> Void

    var body: some View {
        ZStack {
            Color.customPurple
                .edgesIgnoringSafeArea(.all)

            Image("Fairy")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 170, maxHeight: 140)
                .opacity(isAnimating ? 0.8 : 1.0)
                .onAppear {
                    animateImages()
                }
        }
    }

    private func animateImages() {
        withAnimation(Animation.easeInOut(duration: 0.17).repeatForever(autoreverses: true)) {
            isAnimating.toggle()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            completion()
        }
    }
}
