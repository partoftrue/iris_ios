import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedLanguage = "한국어"
    @State private var showingLogoutAlert = false
    
    let languages = ["한국어", "English"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("앱 설정")) {
                    // Language Selection
                    Picker("언어", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                    
                    // Theme Toggle
                    Toggle("다크 모드", isOn: Binding(
                        get: { themeManager.colorScheme == .dark },
                        set: { _ in themeManager.toggleTheme() }
                    ))
                }
                
                Section(header: Text("계정")) {
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        Text("로그아웃")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("앱 정보")) {
                    HStack {
                        Text("버전")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("설정")
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("로그아웃"),
                    message: Text("정말 로그아웃 하시겠습니까?"),
                    primaryButton: .destructive(Text("로그아웃")) {
                        // Add logout action
                    },
                    secondaryButton: .cancel(Text("취소"))
                )
            }
        }
    }
} 