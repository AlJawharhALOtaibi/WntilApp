//
//  MainPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//

import SwiftUI
import CoreData

struct MainPage: View {    
    @State private var showOtherObjectView = false
    @State private var currentLevel = 5
    @State private var upcomingLevel = 9
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        TabView {
            HomeView(currentLevel: $currentLevel, upcomingLevel: $upcomingLevel, showOtherObjectView: $showOtherObjectView)
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Main")
                }
                     
            
            HistoryPage()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("History")
                }
        }
        .accentColor(.customBlue)
        .navigationBarBackButtonHidden(true)
        .onAppear {
        }
    }
    
    
    struct HomeView: View {
        
        @Binding var currentLevel: Int
        @Binding var upcomingLevel: Int
        @Binding var showOtherObjectView: Bool
        @State private var objects: [(name: String, emoji: String)] = [
                    ("Object1", "🌟"), ("Object2", "🚀"), ("Object3", "🌈"),
                    ("Object4", "🌺"), ("Object5", "🎉"), ("Object6", "🎸"),
                    ("Object7", "🍕"), ("Object8", "🚲"), ("Object9", "📚"),
                    ("Object10", "🍦"), ("Object11", "🏆"), ("Object12", "🎨"),
                    ("Object13", "🌍"), ("Object14", "🛸"), ("Object15", "🌕")
                ]

        @State private var selectedObject: (name: String, emoji: String)?
        
        
        var body: some View {
            NavigationView {
                ZStack {
                    VStack {
                        HStack {
                            VStack {
                                Text(greetingByTime())
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.leading, -2)
                                
                                Text("Ready to burn and win?")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                    .padding(.leading, -10)
                            }
                            Spacer()
                            
                            NavigationLink(destination: ProfileView()) {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .padding()
                                    .accessibility(label: Text("Profile"))
                            }
                        }
                        .padding()
                        
                        LevelCardView(currentLevel: $currentLevel, upcomingLevel: $upcomingLevel)
                        
                        Text("Fairy has selected your challenge. Start Walking!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
                        
                        Image("CenterFire")
                            .resizable()
                            .frame(width: 170, height: 220)
                            .overlay(
                                VStack {
                                    Text(selectedObject?.emoji ?? "Click to Start")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                    
                                    Text(selectedObject?.name ?? "")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            )
                            .onTapGesture {
                                if !showOtherObjectView {
                                    objects.shuffle()
                                    selectedObject = objects.randomElement()
                                }
                            }
                            .accessibility(label: Text("Challenge Image"))
                            .accessibility(hint: Text("Tap to change the challenge"))
                        
                        Button(action: {
                        }) {
                            NavigationLink(destination: WalkPage(),
                                           isActive: $showOtherObjectView) {
                                Text("Let's Go!")
                                    .font(.headline)
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(.white)
                                    .background(Color.customBlue)
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                            }
                        }
                        .accessibility(label: Text("Start Walking Button"))
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
                
        func greetingByTime() -> String {
            let currentDate = Date()
            let calendar = Calendar.current
            let currentHour = calendar.component(.hour, from: currentDate)
            
            if 5 <= currentHour && currentHour < 12 {
                return "Good Morning!"
            } else if 12 <= currentHour && currentHour < 18 {
                return "Good Afternoon!"
            } else {
                return "Good Evening!"
            }
        }
    }
    
    struct LevelCardView: View {
        @Binding var currentLevel: Int
        @Binding var upcomingLevel: Int
        
        var body: some View {
            ZStack {
                Image("Card")
                    .resizable()
                    .frame(width: 330, height: 150)
                
                VStack {
                    HStack {
                        Text("Your current level and what lies ahead for the subsequent level!")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        CircularProgressView(progress: CGFloat(currentLevel) / CGFloat(upcomingLevel))
                            .frame(width: 70, height: 70)
                        
                    }
                    .padding()
                    
                }
                .padding()
            }
            .cornerRadius(10)
        }
    }
    
    
    struct CircularProgressView: View {
        var progress: CGFloat
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.2)
                    .foregroundColor(Color.customLightBlue)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.customBlue)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear)
                
                Image("FirstLevel")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.yellow)
            }
        }
    }
    
}
