import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Quick Actions
                    HStack(spacing: 15) {
                        QuickActionButton(title: "근무 체크", icon: "checkmark.circle.fill")
                        QuickActionButton(title: "일정 추가", icon: "plus.circle.fill")
                        QuickActionButton(title: "기록 작성", icon: "pencil.circle.fill")
                    }
                    .padding(.horizontal)
                    
                    // Today's Schedule
                    VStack(alignment: .leading, spacing: 10) {
                        Text("오늘의 일정")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScheduleCardView(
                            date: Date(),
                            employee: "홍길동",
                            time: "09:00 - 18:00"
                        )
                    }
                    
                    // Recent Records
                    VStack(alignment: .leading, spacing: 10) {
                        Text("최근 기록")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        RecordCardView(
                            title: "오늘의 근무 기록",
                            content: "오늘은 평소보다 손님이 많았습니다.",
                            date: Date()
                        )
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("아이리스")
            .navigationBarItems(trailing: 
                Button(action: { themeManager.toggleTheme() }) {
                    Image(systemName: themeManager.colorScheme == .dark ? "sun.max.fill" : "moon.fill")
                }
            )
        }
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {}) {
            VStack {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
    }
}

struct ScheduleCardView: View {
    let date: Date
    let employee: String
    let time: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(employee)
                .font(.headline)
            
            Text(time)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct RecordCardView: View {
    let title: String
    let content: String
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.headline)
            
            Text(content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
} 