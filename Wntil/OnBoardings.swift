//
//  OnBoardings.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 12/07/1445 AH.
//

import SwiftUI

struct Page : Identifiable {
    var id : Int
    var image : String
    var title : String
    var descrip : String
}

var Data = [
    Page(id: 0, image: "ob1", title: "Walk to Hunt!", descrip: "Explore within our historical sites, hunting for clues of our legacies and history, a lot of  treasures are wait for your discovery."),
    
    Page(id: 1, image: "ob2", title: "Walk to Win!", descrip: "Take a walk to catch one of our Riyadh flags, with the iconic Kingdom Tower invites you to explore its surroundings."),

    Page(id: 2, image: "ob3", title: "Walk to Burn!", descrip: "Walk and witness how buildings reach for the sky. Burn calories and dispel any bad mood along the way.")
]


struct OnBoardings: View {
    @State var showSheetView = false
    @State private var currentPage = 0

    var body: some View {
        NavigationView {
            ZStack{
             
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(0..<Data.count) { index in
                            GeometryReader { geometry in
                                VStack {
                                    HStack{
                                        Text(Data[index].title)
                                            .font(.title).bold()
                                            .padding(.top, 100)
                                            .foregroundColor(.customBlue)
                                            .padding(.bottom, 10)
                                        
                                    } .padding(.trailing, 170)
                                 
                                    
                                    Text(Data[index].descrip)
                                        .padding(.horizontal)
                                    
                                    ZStack{
                                   
                                        Image("clouds")
                                            .padding(.bottom, 30)
                                      
                                        ZStack{
                                            Image(Data[index].image)
                                                .padding(.top, 170)
                                            
                                            Image("fairyWalking")
                                                .padding(.top, 300)

                                        }
                                        
                                    }}

                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: currentPage == Data.count - 1 ? .never : .always))
                    .edgesIgnoringSafeArea(.top)
                    
                    if currentPage == Data.count - 1 {
                        NavigationLink(destination: MainPage()) 
                        {
                            Text("Start")
                                .font(.headline)
                                .frame(width: 300, height: 50)
                                .background(Color.customBlue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                        }
                    }
                    Spacer(minLength: 40)
                }}
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: skipButton)
        }
    }
    
    private var skipButton: some View {
        if currentPage < 2 {
            return AnyView(NavigationLink(destination: MainPage()) {
                Text("Skip")
                    .font(.headline)
                    .padding(.trailing, 15)
                    .foregroundColor(.customRed)

            })
        } else {
            return AnyView(EmptyView())
        }
    }
}



