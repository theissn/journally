//
//  headjourApp.swift
//  headjour
//
//  Created by Theis on 22/01/2023.
//

import SwiftUI

@main
struct headjourApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
