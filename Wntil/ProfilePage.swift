//  ProfilePage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//

import SwiftUI
import SafariServices

struct ProfilePage: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Profile")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Spacer()
                    
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                }
                .padding()
                
                List {
                    
                    
                    Text("Personal Information")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    WalkingStatsView(steps: 22, calories: 400, time: "30")
                    
                    Section(header:
                                Text("Know about Fairy")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    ){
                        VStack {
                            
                            //                            Text("Story")
                            //                                .font(.headline)
                            //                                .foregroundColor(.black)
                            //                            
                            NavigationLink(destination: WebView(url: URL(string: "https://www.tiktok.com/@wntil_app?_t=8jWFVqOJXSK&_r=1")!)) {
                                HStack {
                                    Image("tiktok")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    
                                    Text("TikTok")
                                        .font(.headline)
                                    
                                }
                            }
                            
                            .padding()
                            
                            NavigationLink(destination: WebView(url: URL(string: "https://x.com/wntilapp?s=21&t=yHsX53HCYXesuCKf9cmD9Q")!)) {
                                HStack {
                                    Image("x")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .clipShape(Circle())
                                    
                                    Text("X")
                                        .font(.headline)
                                    
                                }     // .padding(.leading)
                                
                            }                             .padding()
                            
                            
                        }
                        
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .frame(width: 350)
                        .padding(.horizontal)
                        
                    }
                    
                    //                    Section {
                    //                        PremiumButtonView()
                    //                    }
                }
                .listStyle(PlainListStyle())
            }
            
        } .navigationBarHidden(true)             .navigationBarBackButtonHidden(true)
    }
       

    
}


struct WalkingStatsView: View {
 
    
    let steps: Int
    let calories: Int
    let time: String
    
    var body: some View {
        
       
        VStack {
            Text("Walking Stats")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .padding(.trailing, 170)
                .padding()
            
            HStack{
                
                WalkingStatBoxView(value: steps, label: "Steps", systemName: "figure.walk")
                WalkingStatBoxView(value: calories, label: "Cal", systemName: "flame.fill")
                WalkingStatBoxView(value: time, label: "Time", systemName: "hourglass")
            }  .padding()
            
        }
        
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5)
        )
        .frame(width: 350)
        .padding()
    }
}

struct WalkingStatBoxView: View {
    let value: Any
    let label: String
    let systemName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .font(.largeTitle)
                .foregroundColor(Color(hex: 0x2D1A8E))
            Text("\(String(describing: value))")
                .font(.headline)
                .foregroundColor(Color(hex: 0x2D1A8E))
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color(hex: 0x2D1A8E))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .frame(width: 79)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5)
        )
        .frame(width: 90)
        .padding(.horizontal,5)
    }
}





struct WebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}

//struct PremiumButtonView: View {
//    var body: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
//                Image(systemName: "crown.fill")
//                    .foregroundColor(.white)
//                Text("Go Premium")
//                    .foregroundColor(.white)
//                    .font(.headline)
//                    .bold()
//                Spacer()
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 30).fill(Color.yellow))
//            Spacer()
//        }
//    }
//}
//

