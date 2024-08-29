//
//  SettingsView.swift
//  ExpenseTrackerApp
//
//  Created by Mohamed Fuad on 8/24/24.
//

import SwiftUI

struct SettingsView: View {
    
    @State var toggleDarkMode: Bool = false
    
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
//                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                
                HStack {
                    Image(systemName: "circle.lefthalf.filled")
                        .symbolEffect(.rotate)
                    Toggle(isOn: $toggleDarkMode) {
                        Text("Dark Mode")
                    }
                }
//                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                
                NavigationLink {
                    Text("Navigation")
                        .padding()
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                    }
                }
//                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                
                NavigationLink {
                    Text("view")
                } label: {
                    HStack {
                        Image(systemName: "yensign.gauge.chart.leftthird.topthird.rightthird")
                        Text("Profile")
                    }
                }
//                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)
                NavigationLink {
                    Text("view")
                } label: {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
//                .listRowBackground(isOn ? Color.black.opacity(1) : Color.white)

            }
           
            
            .scrollContentBackground(.hidden)
            .background( Color("BgColor").ignoresSafeArea())
            
        }
    }
}





#Preview {
    SettingsView()
}
