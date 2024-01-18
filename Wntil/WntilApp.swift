//
//  WntilApp.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//

import SwiftUI

@main
struct WntilApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
