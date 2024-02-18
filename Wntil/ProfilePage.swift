import SwiftUI
import SafariServices

struct ProfilePage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedHistoryItem: HistoryItem?

    var body: some View {
        NavigationView {
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
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                }
                .padding()
                
                List {
                    VStack {
                        Text("اعدادات عامة")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .trailing) // Align text to the trailing edge
                    }
                    
                    // Leap Mode Toggle
                    Toggle(isOn: .constant(true)) { // Here we use a constant binding
                        Text("Leap مظهر")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                    
                    Section(header:
                                VStack {
                                    Text("تابعنا على")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .trailing) // Align text to the trailing edge
                                }
                    ) {
                        VStack {
                            NavigationLink(destination: WebView(url: URL(string: "https://www.tiktok.com/@wntil_app?_t=8jWFVqOJXSK&_r=1")!)) {
                                HStack {
                                    Image("tiktok")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    
                                    Text("TikTok")
                                        .font(.headline)
                                    
                                }
                                .padding()
                            }
                            
                            NavigationLink(destination: WebView(url: URL(string: "https://x.com/wntilapp?s=21&t=yHsX53HCYXesuCKf9cmD9Q")!)) {
                                HStack {
                                    Image("x")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .clipShape(Circle())
                                    
                                    Text("X")
                                        .font(.headline)
                                    
                                }
                                .padding()
                            }
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
                    
                    // Add HistoryPage section
                    Section(header:
                        VStack {
                            Text("جولاتك السابقة")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    ) {
                        
                        HistoryPage { historyItem in
                            selectedHistoryItem = historyItem // Update selected history item
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill available space
                    }
                }
                .listStyle(PlainListStyle())
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
}

struct WebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
