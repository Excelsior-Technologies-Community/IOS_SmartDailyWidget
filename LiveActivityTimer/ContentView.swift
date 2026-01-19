//
//  ContentView.swift
//  LiveActivityTimer
//
//  Created by Noman belim on 19/01/26.
//
import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(spacing: 20) {

            Text("Widget Demo App")
                .font(.largeTitle)
                .bold()

            Text("This app is used to test WidgetKit widgets.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
