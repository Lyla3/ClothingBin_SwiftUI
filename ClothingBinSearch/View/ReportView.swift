import SwiftUI

struct ReportView: View {
    @State private var selectedButtonLabel: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("신고 사유를 입력해주세요.")
            ReportButtonView(label: "의류수거함 위치가 다릅니다.", isSelected: $selectedButtonLabel)
            ReportButtonView(label: "신고 사유를 입력해주세요.", isSelected: $selectedButtonLabel)
            // You can add more buttons here if needed
        }
        .padding()
    }
}

struct ReportButtonView: View {
    let label: String
    @Binding var isSelected: String?
    
    var body: some View {
        Button(action: {
            isSelected = label
            // Handle button action here
        }) {
            HStack {
                Text(label)
                Spacer()
                Image(systemName: "chevron.forward")
            }
            .foregroundStyle(.black)

            .padding(.vertical, 10)
            .background(isSelected == label ? Color.gray.opacity(0.3) : Color.clear)
            .onChange(of: isSelected) { newValue in
                            if newValue == label {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    isSelected = nil
                                }
                            }
                        }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
