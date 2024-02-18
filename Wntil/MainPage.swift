
//  SplashPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 10/07/1445 AH.
//  Fix the backgraound image

import SwiftUI
import CoreData

struct MainPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var showOtherObjectView: Bool
    @State private var showButton = false
    @State private var objects: [(name: String, emoji: String)] = [
        ("أحمر", "🔴"), ("أزرق", "🔵"), ("أخضر", "🟢"),
        ("سيكل", "🚲"), ("قطار", "🚈"), ("باص", "🚌"),
        ("مطعم", "🍽️"), ("مقهى", "☕️"), ("مسجد", "🕌"), ("علامة التوقف", "⛔️"), ("حديقة", "🌳"), ("قطة", "🐈"), ("لمبة", "💡"), ("ورده", "🌷"), ("أصفر", "🌕")
    ]

    @State private var selectedObject: (name: String, emoji: String)?

    
    var body: some View {
        
        NavigationView {
            ZStack {
                ZStack {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        Spacer().frame(height: 50)
                        HStack {
                            
                            NavigationLink(destination: ProfilePage()) {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 2)
                                    .accessibility(label: Text("Profile"))
                            }
                            
                            Spacer()
                            
                            VStack {
                                

                                
                                Text(greetingByTime())
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.leading,-15)
                                
                                    .padding(.bottom,4)
                                
                                Text("مستعد تنافس مشعل؟")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 13))
                                    .padding(.leading, -5)
                            }
                        }
                        .padding()
                        
                        Spacer().frame(height: 100)

                        Text("مشعل اختار لك تحدي، قدها؟")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                        
                        
                        
                        Image("CenterFire")
                            .resizable()
                            .frame(width: 170, height: 220)
                            .padding(.bottom,20)
                            .overlay(
                                VStack {
                                    Text(selectedObject?.emoji ?? "ابدأ")
                                        .padding(.top, 110)
                                        .font(.system(size: 30))
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    Text(selectedObject?.name ?? "")
                                        .font(.headline)
                                        .font(.system(size: 100))
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
                        
                        
                        Text("ملاحظة: اضغط مره ثانية إذا ودك تختار بنفسك")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.top, 2)
                            .padding(.bottom,10)
                        
                        
                        if showButton {
                            NavigationLink(destination: WalkPage(selectedObject: $selectedObject), isActive: $showOtherObjectView) {
                                Text("شعلها !")
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
    }
            
    func greetingByTime() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        if 5 <= currentHour && currentHour < 12 {
            return "صباح الخير !"
            
        } else {
            return "مساء الخير !"
        }
    }
    
    
}
