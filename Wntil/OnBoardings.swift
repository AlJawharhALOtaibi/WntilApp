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

var pages : [Page] = [
    Page(id: 0, image: "ob1", title: "Walk to Hunt!", descrip: "Let each step be an adventure, as the pursuit adds excitement to your walk."),
    Page(id: 1, image: "ob2", title: "Walk to Win!", descrip: "Share the path with familiar faces, creating lasting memories and celebrating each stride."),
    Page(id: 2, image: "ob3", title: "Walk to Burn!", descrip: "Transform each step into a fitness adventure, fostering a healthier and more energetic lifestyle.")
]


struct OnBoardings: View {
    @State var showSheetView = false
    @State private var currentPage = 0
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor =   .blue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    var body: some View {
        NavigationView {
            ZStack{
             
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(0..<pages.count) { index in
                            GeometryReader { geometry in
                                VStack {
                                    Image(pages[index].image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
                                        .padding()
                                    
                                    Text(pages[index].title)
                                        .font(.title).bold()
                                        .padding()
                                        .multilineTextAlignment(.center)
                                    Text(pages[index].descrip)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.gray)
                                        .padding(.horizontal)
                                }
                                .opacity(Double(geometry.frame(in: .global).minX) / 200 + 1)
                                .frame(width: UIScreen.main.bounds.width)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: currentPage == pages.count - 1 ? .never : .always))
                    .edgesIgnoringSafeArea(.top)
                    
                    if currentPage == pages.count - 1 {
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

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardings()
    }
}



