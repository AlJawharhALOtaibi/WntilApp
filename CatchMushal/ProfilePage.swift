import SwiftUI
import SafariServices

struct ProfilePage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedHistoryItem: HistoryItem?
    @State private var isHistoryExpanded = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customPurple
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Image("Profile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Spacer()
                        
                        Text("الملف الشخصي")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 10)
                    }
                    .padding()
                    
                        Section(header: Text("تابعنا على")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.leading, 200)
                            .foregroundColor(.white)) {
                                HStack{
                                    NavigationLink(destination: WebView(url: URL(string: "https://www.tiktok.com/@wntil_app?_t=8jWFVqOJXSK&_r=1")!)) {
                                        HStack {
                                            Image("tiktok")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30, height: 30)
                                            Text("TikTok")
                                                .font(.headline)
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 100)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 0.5)
                                        )
                                        .background(.gray.opacity(0.2))
                                    }
                                    
                                    NavigationLink(destination: WebView(url: URL(string: "https://x.com/wntilapp?s=21&t=yHsX53HCYXesuCKf9cmD9Q")!)) {
                                        HStack {
                                            Image("x")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                            Text("X")
                                                .font(.headline)
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 100)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 0.5)
                                        )
                                        .background(.gray.opacity(0.2))
                                    }
                                }
                            }

                    VStack{
                        
                       Text("")
                            .padding(.bottom,30)
                        
                    }
                        Section(header: Text("جولاتك السابقة")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.leading, 170)
                            .foregroundColor(.white)) {
                              
                                    HistoryPage { historyItem in
                                        }  

                        }
                   
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            if gesture.translation.width > 100 {
                                // Swipe right, so dismiss the profile page
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
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
