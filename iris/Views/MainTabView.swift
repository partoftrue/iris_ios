import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    init() {
        print("MainTabView initialized")
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
                .tag(0)
            
            WorkView()
                .tabItem {
                    Label("근무", systemImage: "briefcase.fill")
                }
                .tag(1)
            
            ScheduleView()
                .tabItem {
                    Label("일정", systemImage: "calendar")
                }
                .tag(2)
            
            RecordView()
                .tabItem {
                    Label("기록", systemImage: "note.text")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Label("설정", systemImage: "gear")
                }
                .tag(4)
        }
        .accentColor(.blue)
        .onAppear {
            // Set the tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
} 