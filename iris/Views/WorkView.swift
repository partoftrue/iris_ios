import SwiftUI

enum WorkStatus {
    case upcoming
    case completed
}

struct WorkView: View {
    @State private var selectedRole: UserRole = .employee
    @State private var showingAddWork = false
    
    enum UserRole {
        case employee
        case employer
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Role Selector
                Picker("역할", selection: $selectedRole) {
                    Text("알바생").tag(UserRole.employee)
                    Text("사장님").tag(UserRole.employer)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedRole == .employee {
                    EmployeeView()
                } else {
                    EmployerView()
                }
            }
            .navigationTitle("근무 관리")
            .navigationBarItems(trailing: 
                Button(action: { showingAddWork = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddWork) {
                AddWorkView()
            }
        }
    }
}

struct EmployeeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Today's Work
                WorkCard(
                    title: "오늘의 근무",
                    time: "09:00 - 18:00",
                    location: "카페 알바",
                    status: .upcoming
                )
                
                // Recent Work History
                VStack(alignment: .leading, spacing: 10) {
                    Text("근무 기록")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    WorkHistoryCard(
                        date: "2024-05-08",
                        time: "09:00 - 18:00",
                        location: "카페 알바",
                        status: .completed
                    )
                    
                    WorkHistoryCard(
                        date: "2024-05-07",
                        time: "13:00 - 22:00",
                        location: "카페 알바",
                        status: .completed
                    )
                }
            }
            .padding(.vertical)
        }
    }
}

struct EmployerView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Employee List
                VStack(alignment: .leading, spacing: 10) {
                    Text("알바생 목록")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    EmployeeCard(name: "김철수", role: "카페 알바")
                    EmployeeCard(name: "이영희", role: "카페 알바")
                }
                
                // Work Schedule
                VStack(alignment: .leading, spacing: 10) {
                    Text("근무 일정")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScheduleCard(
                        date: "2024-05-09",
                        employee: "김철수",
                        time: "09:00 - 18:00"
                    )
                }
            }
            .padding(.vertical)
        }
    }
}

struct WorkCard: View {
    let title: String
    let time: String
    let location: String
    let status: WorkStatus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(time)
                        .font(.title3)
                        .bold()
                    Text(location)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text(status == .upcoming ? "체크인" : "완료")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(status == .upcoming ? Color.blue : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct WorkHistoryCard: View {
    let date: String
    let time: String
    let location: String
    let status: WorkStatus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(time)
                        .font(.body)
                    Text(location)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text(status == .completed ? "완료" : "예정")
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(status == .completed ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundColor(status == .completed ? .green : .blue)
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct EmployeeCard: View {
    let name: String
    let role: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(role)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("일정 관리")
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct ScheduleCard: View {
    let date: String
    let employee: String
    let time: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(employee)
                        .font(.headline)
                    Text(time)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("수정")
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(4)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct AddWorkView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("근무 정보")) {
                    TextField("근무 시간", text: .constant(""))
                    TextField("근무 장소", text: .constant(""))
                }
                
                Section(header: Text("알바생")) {
                    TextField("알바생 이름", text: .constant(""))
                }
            }
            .navigationTitle("근무 추가")
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