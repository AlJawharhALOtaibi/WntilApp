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
        @State private var showButton = false
        @Binding var currentLevel: Int
        @Binding var upcomingLevel: Int
        @Binding var showOtherObjectView: Bool
        @State private var objects: [(name: String, emoji: String)] = [
                    ("Red", "🔴"), ("Blue", "🔵"), ("Green", "🟢"),
                    ("Bicycle", "🚲"), ("Train", "🚈"), ("Bus", "🚌"),
                    ("Restaurant", "🍽️"), ("Cafe", "☕️"), ("Mosque", "🕌"), ("Stop Sign", "⛔️"), ("Park", "🌳"), ("Cat", "🐈"), ("Lighting", "💡"), ("Flowers", "🌷"), ("Yellow", "🌕")
                ]

        @State private var selectedObject: (name: String, emoji: String)?
        
        
        var body: some View {
            NavigationView {
                ZStack {
                    VStack {
                        HStack {
                            
                            VStack {
                                Text(greetingByTime())
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.leading,-15)
                                
                                    .padding(.bottom,4)

                                Text("Ready to burn and win?")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 13))                              .padding(.leading, -5)
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: ProfilePage()) {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 2)
                                    .accessibility(label: Text("Profile"))
                            }
                        }
                        .padding()
                        
                        LevelCardView(currentLevel: $currentLevel, upcomingLevel: $upcomingLevel)
                        
                        Text("Fairy has selected your challenge:")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                            .padding(.horizontal)

                        Text("If you wish to select a different object, please double-click.")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.top, 2)
                            .padding(.bottom,10)
                        
                        Image("CenterFire")
                                          .resizable()
                                          .frame(width: 170, height: 220)
                                          .padding(.bottom,20)
                                          .overlay(
                                              VStack {
                                                  Text(selectedObject?.emoji ?? "Start")
                                                      .padding(.top, 110)
                                                      .font(.system(size: 30))
                                                      .bold()
                                                      .foregroundColor(.white)

                                                  Text(selectedObject?.name ?? "")
                                                      .font(.headline)
                                                      .font(.system(size: 40))
                                                      .foregroundColor(.white)
                                              }
                                          )
                                          .onTapGesture {
                                              if !showOtherObjectView {
                                                  objects.shuffle()
                                                  selectedObject = objects.randomElement()
                                                  showButton = true
                                              }
                                          }
                                          .accessibility(label: Text("Challenge Image"))
                                          .accessibility(hint: Text("Tap to change the challenge"))

                                      if showButton {
                                          NavigationLink(destination: WalkPage(), isActive: $showOtherObjectView) {
                                              Text("Let's Go!")
                                                  .font(.headline)
                                                  .frame(width: 300, height: 50)
                                                  .foregroundColor(.white)
                                                  .background(Color.customBlue)
                                                  .cornerRadius(10)
                                                  .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                                          }
                                          .accessibility(label: Text("Start Walking Button"))
                                      }


                        
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
                        Text("Achieve the next level by taking a 10,000-step walk!")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .padding(.horizontal)
                        
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
