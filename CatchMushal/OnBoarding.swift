import SwiftUI

struct OnBoardings: View {
    @State var showSheetView = false
    @Binding var showOtherObject: Bool
    @Binding var showOtherObjectView: Bool
    @State private var showAlert = false // State variable to control the alert
    @State private var navigateToMainPage = false // State variable to control navigation to the main page
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.customPurple
                
                VStack {
                    Text("ألحق مشعل")
                        .padding(.top,150)
                        .padding(.bottom,80)
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(.white)
                    
                    Text("موجود يشعّل المشي عليك،")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text( "ويعطيك تحديات لليوم وكل يوم!")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text("تذكر دائمًا انك قدها و #شعلها")
                        .padding(.top,20)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        // Set showAlert to true when the button is tapped
                        showAlert = true
                    }) {
                        Text("تعرف على مشعل")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .background(Color.customBlue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    }
                    
                    ZStack{
                        Spacer()
                        Image("OnBoarding")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 600, height: 300)
                            .padding(.top, 170)
                    }.edgesIgnoringSafeArea(.all)
                }
            }.edgesIgnoringSafeArea(.all)
            .alert(isPresented: $showAlert) {
                // Present an alert when showAlert is true
                Alert(title: Text("استمتع بنسخة مشعل #Leap24"),
                      message: Text("ولا تنسى تستمتع بالمؤتمر"),
                      dismissButton: .default(Text("أكيد"), action: {
                        // Navigate to main page when OK is tapped
                        navigateToMainPage = true
                      }))
            }
            .background(
                NavigationLink(destination: MainPage(showOtherObject: $showOtherObject, showOtherObjectView: $showOtherObjectView), isActive: $navigateToMainPage) {
                    EmptyView()
                }
            )
        }.navigationBarBackButtonHidden(true)
    }
}
