//
//  NumberPickerApp.swift
//  NumberPicker
//
//  Created by 邱允聰 on 1/9/2022.
//

import SwiftUI

@main
struct NumberPickerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
