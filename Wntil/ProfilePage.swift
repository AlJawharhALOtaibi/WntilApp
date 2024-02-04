//
//  ProfilePage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//

import SwiftUI
import SafariServices

struct ProfilePage: View {

    
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
                Section(header:
                            Text("Personal Information")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                ) {
                    
                }
                
                Section(header:
                            Text("Walking Stats")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                ) {
                    WalkingStatsView(steps:22 , calories: 400, time: "30")
                    
                }
                
                Section (header:
                            Text("Settings")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                ) {
                    //SettingView()
                }
                
                Section (header:
                            Text("Know about Fairy 🔥")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                ){
                    NavigationLink(destination: FairyStoryView()) {
                        Text("Story")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    NavigationLink(destination: WebView(url: URL(string: "https://www.tiktok.com/@wntil_app?_t=8jWFVqOJXSK&_r=1")!)) {
                        Text("TikTok")
                            .font(.headline)
                            .foregroundColor(.customBlue)
                    }
                    
                    NavigationLink(destination: WebView(url: URL(string: "https://x.com/wntilapp?s=21&t=yHsX53HCYXesuCKf9cmD9Q")!)) {
                        Text("X")
                            .font(.headline)
                            .foregroundColor(.customBlue)
                    }
                }
                Section(){
                    
                    PremiumButtonView()
                    
                }
            }
            .listStyle(PlainListStyle())
        }
        }         .navigationBarHidden(true)

    }
}


struct WalkingStatsView: View {
 
    
    let steps: Int
    let calories: Int
    let time: String
    
    var body: some View {
        HStack {
            WalkingStatBoxView(value: steps, label: "Steps", systemName: "figure.walk")
            WalkingStatBoxView(value: calories, label: "Cal", systemName: "flame")
            WalkingStatBoxView(value: time, label: "Time", systemName: "hourglass")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5)
        )
        .frame(maxWidth: .infinity)
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
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5)
        )
    }
}



struct FairyStoryView: View {
    var body: some View {
        VStack {
            
            Text("Fairy Story Page")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()
            
        
        }
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

struct PremiumButtonView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "crown.fill")
                    .foregroundColor(.white)
                Text("Go Premium")
                    .foregroundColor(.white)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 30).fill(Color.yellow))
            Spacer()
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
