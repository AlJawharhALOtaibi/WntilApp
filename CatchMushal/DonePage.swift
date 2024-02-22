import SwiftUI

struct DonePage: View {
    @Binding var showOtherObject: Bool
    @Binding var selected2Object: (name: String, emoji: String)?
    @Binding var showOtherObjectView: Bool
    @State private var isAnimating = false

    var body: some View {
        NavigationView {
            ZStack{
                Color.customPurple
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
                    Image("Fairy")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 170, maxHeight: 140)
                        .opacity(isAnimating ? 0.8 : 1.0)
                        .onAppear {
                            animateImages()
                        }
                        .padding(.bottom,70)
                    
                    Text("والله وطلعت قدها!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("جعل الغنايم دايم في طريقك")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,30)
                    
               //     Spacer()
                    
                    NavigationLink(destination: MainPage(showOtherObject: $showOtherObject, showOtherObjectView:$showOtherObjectView )) {
                        Text("انهي التحدي")
                            .bold()
                            .padding()
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.customBlue)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                          
                    }
                    Spacer()
}
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func animateImages() {
        withAnimation(Animation.easeInOut(duration: 0.17).repeatForever(autoreverses: true)) {
            isAnimating.toggle()
        }
    }
}
