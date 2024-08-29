import SwiftUI

struct TabbarView: View {
    enum Section {
        case homeview
        case cardview
        case settingsview
        case graphview
    }

    @State private var selectedTab = 0
    @StateObject  var vm: ViewModel
 
    @State var showCard: Bool = false
       
    
    var body: some View {
        
        ZStack {
            Color("BgColor").ignoresSafeArea()
            
            NavigationStack {
                
                TabView(selection: $selectedTab) {
                    // Home View Tab
                    CardView( vm: vm, selectedTab: $selectedTab, showCard: $showCard)
                    
                        .tabItem {
                            Image(systemName: "house")
                                .symbolEffect(.breathe, value: selectedTab == 0)
                        }
                        .tag(0)
                    
                    // Card View Tab
                    AddDetailView(vm: vm, selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "creditcard")
                                .symbolEffect(.bounce, value: selectedTab == 1)
                        }
                        .tag(1)
                    
                    // Settings View Tab
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear")
                                .symbolEffect(.bounce, value: selectedTab == 2)
                        }
                        .tag(2)
                    
                    // Graph View Tab
                    GraphView(vm: vm)
                        .tabItem {
                            Image(systemName: "chart.bar")
                                .symbolEffect(.bounce, value: selectedTab == 3)
                        }
                        .tag(3)
                }
            }
            
        }
    }
}

#Preview {
    TabbarView(vm: ViewModel())
}
