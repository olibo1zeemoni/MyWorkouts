//
//  SummaryView.swift
//  MyWorkouts Watch App
//
//  Created by Olibo moni on 01/09/2023.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        if workoutManager.workout == nil {
            ProgressView("Saving workout")
                .navigationBarHidden(true)
        } else {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    SummaryMetricView(
                        title: "Total Time",
                        value: durationFormatter
                            .string(from: workoutManager.workout?.duration ?? 0.0) ?? ""
                    ).accentColor(Color.yellow)
                    SummaryMetricView(
                        title: "Total Distance",
                        value: Measurement(
                            value: workoutManager.workout?.totalDistance?
                                .doubleValue(for: .meter()) ?? 0,
                            unit: UnitLength.meters
                        ).formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .road
                            )
                        )
                    ).accentColor(Color.green)
                    SummaryMetricView(
                        title: "Total Energy",
                        value: Measurement(
                            value: workoutManager.workout?.totalEnergyBurned?
                                            .doubleValue(for: .kilocalorie()) ?? 0,
                            unit: UnitEnergy.kilocalories
                        ).formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .workout,
                                numberFormatStyle: .number.precision(.fractionLength(0))
                            )
                        )
                    ).accentColor(Color.pink)
                    SummaryMetricView(
                        title: "Avg. Heart Rate",
                        value: workoutManager.averageHeartRate
                            .formatted(
                                .number.precision(.fractionLength(0))
                            )
                        + " bpm"
                    ).accentColor(Color.red).accentColor(Color.red)
                    
                    Text("Activity Rings")
                    ActivityRingsView(
                        healthStore: workoutManager.healthStore)
                    .frame(width: 50, height: 50)
                    
                    Button("Done") {
                        dismiss()
                    }
                }
                .scenePadding()
            }
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview("Summary View") {
    SummaryView()
        .environmentObject(WorkoutManager())
}

struct SummaryMetricView: View {
    var title: String
    var value: String

    var body: some View {
        Text(title)
        Text(value)
            .font(.system(.title2, design: .rounded)
                    .lowercaseSmallCaps()
            )
            .foregroundColor(.accentColor)
        Divider()
    }
}

//.number.precision(.fractionLength(0))
