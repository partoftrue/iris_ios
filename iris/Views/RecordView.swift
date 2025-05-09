import SwiftUI

struct RecordView: View {
    @State private var showingAddRecord = false
    @State private var selectedRecordType: Record.RecordType = .text
    
    var body: some View {
        NavigationView {
            VStack {
                // Record Type Selector
                Picker("기록 유형", selection: $selectedRecordType) {
                    Text("텍스트").tag(Record.RecordType.text)
                    Text("이미지").tag(Record.RecordType.image)
                    Text("음성").tag(Record.RecordType.voice)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Record List
                ScrollView {
                    VStack(spacing: 15) {
                        RecordItem(
                            date: "2024-05-09",
                            title: "오늘의 근무 기록",
                            content: "오늘은 평소보다 손님이 많았습니다. 특히 오후 2시부터 4시 사이에 가장 바빴습니다.",
                            type: .text
                        )
                        
                        RecordItem(
                            date: "2024-05-08",
                            title: "근무 일지",
                            content: "새로운 메뉴가 추가되어 교육을 받았습니다.",
                            type: .text
                        )
                    }
                    .padding()
                }
            }
            .navigationTitle("기록")
            .navigationBarItems(trailing: 
                Button(action: { showingAddRecord = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddRecord) {
                AddRecordView(recordType: selectedRecordType)
            }
        }
    }
}

struct RecordItem: View {
    let date: String
    let title: String
    let content: String
    let type: Record.RecordType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.headline)
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Text("더보기")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct AddRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    let recordType: Record.RecordType
    
    @State private var title = ""
    @State private var content = ""
    @State private var selectedImage: UIImage?
    @State private var isRecording = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("기록 정보")) {
                    TextField("제목", text: $title)
                    
                    switch recordType {
                    case .text:
                        TextEditor(text: $content)
                            .frame(height: 200)
                    case .image:
                        VStack {
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                            }
                            
                            Button(action: {
                                // Add image picker action
                            }) {
                                Text("이미지 선택")
                            }
                        }
                    case .voice:
                        VStack {
                            Button(action: {
                                isRecording.toggle()
                            }) {
                                Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                                    .font(.system(size: 64))
                                    .foregroundColor(isRecording ? .red : .blue)
                            }
                            
                            Text(isRecording ? "녹음 중..." : "녹음 시작")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("기록 추가")
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