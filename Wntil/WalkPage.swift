//
//  WalkPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//  
//  UI Done

import SwiftUI

struct WalkPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    @State private var isActiveNavigationLink = false
    var selectedObject: (name: String, emoji: String)?
    
    var body: some View {
        VStack {
            HStack {
                Text("Walking Now")
                    .font(.title)
                    .bold()
                    .padding(.trailing, 110)
                    .accessibility(label: Text("Walking Now"))
                
                Button("End Walk") {
                            showAlert = true
                        }
                        .foregroundColor(.customRed)
                        .bold()
                        .accessibility(label: Text("End Walk"))
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Confirmation"),
                                message: Text("Are you sure you want to end the walk?"),
                                primaryButton: .default(Text("Yes")) {
                                    isActiveNavigationLink = true
                                    presentationMode.wrappedValue.dismiss()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                       
            }

            ZStack {
                Image("Skyline")
                    .resizable()
                    .frame(width: 500, height: 370)
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, 100)
                    .accessibility(label: Text("Skyline image"))

                Image("WalkLine")
                    .resizable()
                    .frame(width: 500, height: 50)
                    .aspectRatio(contentMode: .fill)
                    .padding(.top, 230)
                    .accessibility(label: Text("Walkline image"))
            }

            HStack {
                Image("CenterFire")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(Color.white)
                    .accessibility(label: Text("Fire image"))
                
                Image("CenterFire")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(Color.white)
                    .accessibility(label: Text("Fire image"))
                
                Image("CenterFire")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(Color.white)
                    .accessibility(label: Text("Fire image"))

                Spacer()
            }

        }
        .navigationBarHidden(true)
    }
}
