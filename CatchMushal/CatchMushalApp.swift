//
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.

import SwiftUI
@main
struct CatchMushalApp: App {
    @StateObject private var dataController = DataController()
    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
    @State private var showSplash = true
    @State private var showOtherObjectView = false
    @State private var showOtherObject = false

    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView {
                        withAnimation {
                            showSplash = false
                        }
                    }
                } else if showOnboarding {
                    OnBoardings(showOtherObject: $showOtherObject, showOtherObjectView: $showOtherObjectView)
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                        .onAppear {
                            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                             }
                              } else {
                            MainPage(showOtherObject: $showOtherObject, showOtherObjectView: $showOtherObjectView)
                                .environment(\.managedObjectContext, dataController.container.viewContext)
                            
                            
                    }
            }
        }
    }
}
