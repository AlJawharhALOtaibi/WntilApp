
//  SplashPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 10/07/1445 AH.
//  Fix objects, acess

import SwiftUI
import CoreData

struct MainPage: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var showButton = false
    @State private var objects: [(name: String, emoji: String)] = [
        ("أحمر", "🔴"), ("أزرق", "🔵"), ("أخضر", "🟢"),
        ("سيكل", "🚲"), ("قطار", "🚈"), ("باص", "🚌"),
        ("مطعم", "🍽️"), ("مقهى", "☕️"), ("مسجد", "🕌"), ("علامة التوقف", "⛔️"), ("حديقة", "🌳"), ("قطة", "🐈"), ("لمبة", "💡"), ("ورده", "🌷"), ("أصفر", "🌕")
    ]
    


    @State private var selectedObject: (name: String, emoji: String)?
    @State private var selected2Object: (name: String, emoji: String)?
    @Binding var showOtherObject: Bool
    @Binding var showOtherObjectView: Bool



    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.customPurple
                    .edgesIgnoringSafeArea(.all)
                
                ZStack {
                    
                    Image("cloud")
                         .resizable()
                         .scaledToFill()
                         .edgesIgnoringSafeArea(.all)
                         .frame(width: 200, height: 200)
                         .padding(.bottom, 500)

                     
                     Image("tree")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 400, height: 300)
                         .padding(.top, 670)

                    
                    
                    VStack {
                        
                        Spacer().frame(height: 150)
                        HStack {
                            
                            NavigationLink(destination: ProfilePage()) {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 2)
                                    .accessibility(label: Text("Profile"))
                            }.navigationBarBackButtonHidden(false)
                            
                            Spacer()
                            
                            VStack {
                                

                                Text(greetingByTime())
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.leading,-7)
                                    .foregroundColor(.white)
                                    .padding(.bottom,4)
                                    .bold()
                                
                                Text("مستعد تنافس مشعل؟")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 13))
                                    .padding(.leading, -5)
                            }
                        }
                        .padding(.top,-30)
                        
                        Spacer().frame(height: 100)

                        Text("مشعل اختار لك تحدي، قدها؟")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
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
                                        .padding(.top, 70)
                                        .font(.system(size: 50))
                                        //.bold()
                                        .foregroundColor(.white)
                                    
                                    Text(selectedObject?.name ?? "")
                                        .padding(.bottom,20)
                                        .font(.headline)
                                        .font(.system(size: 100))
                                        .foregroundColor(.white)
                                }
                            )
                            .onTapGesture {
                                if !showOtherObjectView {
                                    objects.shuffle()
                                    selectedObject = objects.randomElement()
                                    selected2Object = objects.randomElement()
                                    showButton = true
                                }
                            }
                            .accessibility(label: Text("Challenge Image"))
                            .accessibility(hint: Text("Tap to change the challenge"))
                        
                        
                        Text("ملاحظة: اضغط مره ثانية إذا ودك تختار بنفسك")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 2)
                            .padding(.bottom,10)
                        
                        
                        if showButton {
                            
                            NavigationLink(destination: WalkPage(selectedObject: $selectedObject, selected2Object: $selected2Object, showOtherObject: $showOtherObject, showOtherObjectView: $showOtherObjectView))
                            
                            {
                                Text("شعلها!")
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
            }.navigationBarTitle("", displayMode: .inline)
           
        } .navigationBarBackButtonHidden(true)
    }
            
    func greetingByTime() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        if 5 <= currentHour && currentHour < 12 {
            return "صباح الخير!"
                
            
        } else {
            return "مساء الخير!"
        }
    }
    
    
}
