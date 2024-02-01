//
//  WntilApp.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//

import SwiftUI

@main
struct WntilApp: App {
    @StateObject private var dataController = DataController()
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")

    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                OnBoardings()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .onAppear {
                        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                    }
            } 
            
            else {
                MainPage()
                    .environment(\.managedObjectContext, dataController.container.viewContext)

                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showOnboarding = true
                            }
                        }
                    }
            }
        }
    }
}
