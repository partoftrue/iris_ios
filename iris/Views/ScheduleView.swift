import SwiftUI

struct ScheduleView: View {
    @State private var selectedDate = Date()
    @State private var showingAddSchedule = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Calendar View
                DatePicker(
                    "날짜 선택",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                // Schedule List
                ScrollView {
                    VStack(spacing: 15) {
                        ScheduleItem(
                            time: "09:00 - 18:00",
                            title: "카페 알바",
                            location: "스타벅스 강남점"
                        )
                        
                        ScheduleItem(
                            time: "19:00 - 21:00",
                            title: "영어 회화",
                            location: "온라인"
                        )
                    }
                    .padding()
                }
            }
            .navigationTitle("일정")
            .navigationBarItems(trailing: 
                Button(action: { showingAddSchedule = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddSchedule) {
                AddScheduleView()
            }
        }
    }
}

struct ScheduleItem: View {
    let time: String
    let title: String
    let location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(time)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.headline)
            
            Text(location)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct AddScheduleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var location = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("일정 정보")) {
                    TextField("제목", text: $title)
                    TextField("장소", text: $location)
                }
                
                Section(header: Text("시간")) {
                    DatePicker("시작 시간", selection: $startTime, displayedComponents: [.hourAndMinute])
                    DatePicker("종료 시간", selection: $endTime, displayedComponents: [.hourAndMinute])
                }
            }
            .navigationTitle("일정 추가")
            .navigationBarItems(
                leading: Button("취소") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("저장") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
} 