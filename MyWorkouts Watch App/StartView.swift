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
        List(workoutTypes) { workoutType in
            NavigationLink(
                workoutType.name,
                destination:  SessionPagingView(),
                tag: workoutType,
                selection: $workoutManager.selectedWorkout
            )
           }
            
            .padding(
                EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
            )
        .listStyle(.carousel)
        .navigationBarTitle("Workouts")
        .onAppear {
            workoutManager.requestAuthorization()
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



