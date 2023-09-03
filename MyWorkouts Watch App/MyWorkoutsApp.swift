//
//  MyWorkoutsApp.swift
//  MyWorkouts Watch App
//
//  Created by Olibo moni on 01/09/2023.
//

import SwiftUI

@main
struct MyWorkouts_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView, content: {
                SummaryView()
            })
            .environmentObject(workoutManager)
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

