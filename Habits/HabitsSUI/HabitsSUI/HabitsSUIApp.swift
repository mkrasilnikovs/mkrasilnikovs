//
//  HabitsSUIApp.swift
//  HabitsSUI
//
//  Created by iosdev on 12/10/2021.
//

import SwiftUI

@main
struct HabitsSUIApp: App {
    @StateObject  var listViewSetUp: ListViewSetUp = ListViewSetUp()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HabitTable()
            }
            .environmentObject(listViewSetUp)
            
        }
    }
}
