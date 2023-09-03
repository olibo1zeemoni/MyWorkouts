//
//  ContentView.swift
//  MyWorkouts Watch App
//
//  Created by Olibo moni on 01/09/2023.
//

import SwiftUI
import HealthKit



struct StartView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]
    
    var body: some View {
        NavigationSplitView {
            List(workoutTypes, selection: $workoutManager.selectedWorkout) { workoutType in
                NavigationLink(workoutType.name, value: workoutType)
                    .listStyle(.carousel)
                    .foregroundStyle(.green)
            }
          
        } detail: {
            SessionPagingView()
        }
        
        .navigationTitle("Workouts")
        .onAppear {
            workoutManager.requestAuthorization()
        }
        .sheet(isPresented: $workoutManager.showingSummaryView) {
            SummaryView()
        }
    }
}

#Preview("StartView") {
    StartView()
        .environmentObject(WorkoutManager())
}


extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }

    var name: String {
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        default:
            return ""
        }
    }
}



