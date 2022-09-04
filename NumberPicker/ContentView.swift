//
//  ContentView.swift
//  NumberPicker
//
//  Created by 邱允聰 on 1/9/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @StateObject var numPick = NumPick()
    @AppStorage("chooseNumber") private var chooseNumber = 1
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        Home()
            .environmentObject(numPick)
            .preferredColorScheme(isDarkMode ? withAnimation{ .dark} : withAnimation{ .light})            
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
