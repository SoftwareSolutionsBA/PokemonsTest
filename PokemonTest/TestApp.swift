//
//  TestApp.swift
//  Test
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import SwiftUI

@main
struct TestApp: App {
	@Environment(\.managedObjectContext) var context

    var body: some Scene {
        WindowGroup {
            ContentView(context: context)
        }
    }
}
