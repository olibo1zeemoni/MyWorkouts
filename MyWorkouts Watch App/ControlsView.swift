//
//  ControlsView.swift
//  MyWorkouts Watch App
//
//  Created by Olibo moni on 01/09/2023.
//

import SwiftUI

struct ControlsView: View {
    var body: some View {
        HStack {
            VStack {
                Button {
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(Color.red)
                .font(.title2)
                Text("End")
            }
            VStack {
                Button {
                } label: {
                    Image(systemName: "pause")
                }
                .tint(Color.yellow)
                .font(.title2)
                Text("Pause")
            }
        }
    }
}

#Preview {
    ControlsView()
}
