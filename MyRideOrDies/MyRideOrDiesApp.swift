//
//  MyRideOrDiesApp.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 25.09.2024.
//

import SwiftUI

@main
struct MyRideOrDiesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, ContactsProvider.shared.viewContext)
        }
    }
}
