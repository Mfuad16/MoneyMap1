//
//  HomeView.swift
//  ExpenseTrackerApp
//
//  Created by Mohamed Fuad on 8/23/24.
//

import SwiftUI


enum TabGroup: Int, CaseIterable {
    case home = 0
    case profile
    case settings
    case notifications
    
    var iconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .profile:
            return "person.fill"
        case .settings:
            return "gearshape.fill"
        case .notifications:
            return "bell.fill"
        }
    }
}


struct HomeView: View {
    @State private var selectedTab = 0
    @State private var isDarkMode: Bool = false
    @StateObject private var MainViewModel = ViewModel()
    
    
    
    var body: some View {
        ZStack {
            if isDarkMode {
                Color.black
                    .ignoresSafeArea()
            } else {
                Color.white
                    .ignoresSafeArea()
            }
               
            // Display content based on selected tab
            customIcon(selectedTab: selectedTab)
            
            VStack {
                Spacer()
                    
                TabBarView(isOn: $isDarkMode, selectedTab: $selectedTab)
                    .padding(.top,20)
                    .frame(width: 400,height: 100)
                    
                    .background(isDarkMode ? .white: .black)
                
//                    .cornerRadius(30)
            }
          
//            .background(.red)
            
            
            
            
            
          
        }
    }
    
    @ViewBuilder
    func customIcon(selectedTab: Int) -> some View {
        switch selectedTab {
        case 0:
            DynamicIslandView(vm: MainViewModel, selectedTab: $selectedTab)
        case 1:
            CardView(vm: MainViewModel)
        case 2:
            SettingsView(isOn: $isDarkMode)
        // Add more cases as needed
        default:
            DynamicIslandView(vm: MainViewModel, selectedTab: $selectedTab) // Or some default view
        }
    }
    
    
    
}


struct TabBarView: View {
    @Binding var isOn: Bool
    @Binding var selectedTab: Int
    @State var tab: Int = 0
//    @State var currentlySelected: TabGroup = .home
    
    var body: some View {
        HStack(spacing: 25) {
            ForEach(TabGroup.allCases,id: \.self) { tab in
                
                TabIconView(isOn: $isOn, selectedTab: $selectedTab, value: tab.rawValue, iconName: tab.iconName)
                    .padding(.bottom,10)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedTab = tab.rawValue
                            print(selectedTab)
                            print(tab.rawValue)
                           
                                                                            }
                    
                    }
                    
                  
            
            }
            .foregroundColor(.white)
            
            
        }
        
   

        
    }
}


struct TabIconView: View {
    @Binding var isOn: Bool
    @Binding var selectedTab: Int
    var value: Int
    var iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 22))
            .frame(width: 60,height: 60)
            
            .foregroundColor(isOn ? .black : .white)
           
            .background(selectedTab == value ? Color.blue.opacity(0.8) : (isOn ? Color.white : Color.black))
//            .padding(.vertical,30)
            .cornerRadius(selectedTab == value ? 30 : 0)
            .symbolEffect(.bounce, value: selectedTab == value)
            .onTapGesture {
                withAnimation(.spring) {
                    selectedTab = value
                }
            }
    }
}

#Preview {
    HomeView()
}
