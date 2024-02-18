//
//  DonePage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//  Almost Completed: Image Not Showing

import SwiftUI

struct DonePage: View {
    @State private var showOtherObjectView = false
    var body: some View {
        VStack {
            
            Image("Fairy") 
                .resizable()
                .padding()
                .accessibility(label: Text("Well Done Image"))
            
            Text("Well Done!!")
                .font(.title)
                .fontWeight(.bold)
                .accessibility(label: Text("Well Done Title"))
            
            Text("Happy walks ahead of you.")
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .accessibility(label: Text("Completion Subtitle"))
            
     
            NavigationLink(destination: MainPage(showOtherObjectView: $showOtherObjectView)
) {
                Text("Back To Main Page")
                    .font(.headline)
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .background(Color.customBlue)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    .accessibility(label: Text("Back To Main Page"))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DonePage_Previews: PreviewProvider {
    static var previews: some View {
        DonePage()
    }
}

