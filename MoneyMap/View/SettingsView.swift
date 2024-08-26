//
//  SettingsView.swift
//  ExpenseTrackerApp
//
//  Created by Mohamed Fuad on 8/24/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isOn: Bool
    var body: some View {
        NavigationStack {
            List(){
                NavigationLink {
                    Text("view")
                } label: {
                    HStack {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
                }
                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                
                HStack {
                    Image(systemName: "circle.lefthalf.filled")
                        .symbolEffect(.rotate, value: isOn)
                    Toggle(isOn: $isOn) {
                        Text("Dark Mode")
                    }
                }
                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                
                NavigationLink {
                    DarkMode(isOn: $isOn)
                        .padding()
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                    }
                }
                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                
                NavigationLink {
                    Text("view")
                } label: {
                    HStack {
                        Image(systemName: "yensign.gauge.chart.leftthird.topthird.rightthird")
                        Text("Profile")
                    }
                }
                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                NavigationLink {
                    Text("view")
                } label: {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)

            }
           
            .foregroundColor(isOn ? .white : .black)
            .scrollContentBackground(.hidden)
//            .background(isOn ? .gray : .b)
            .background(isOn ? .black : .white)
        }
    }
}

struct DarkMode: View {
    @Binding var isOn: Bool
    var body: some View {
        ZStack {
           
            Toggle(isOn: $isOn) {
                Text("Dark Mode")
            }
        }
        
        
    }
       
}



#Preview {
    SettingsView(isOn: .constant(false))
}
