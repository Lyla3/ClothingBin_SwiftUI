import SwiftUI

struct ReportView: View {
    @State private var selectedButtonLabel: String? = nil
    @State var pressedReportButton: Bool = false
    @Binding var isShowingReportView: Bool
    @State var isShowingReportCheckView: Bool = false

    var body: some View {
        ZStack{
            //MARK: - ReportCheckView
//            if pressedReportButton{
//                ReportCheckView(pressedReportButton: $pressedReportButton, isShowingReportView: $isShowingReportView)
//            }
                
            
            
            //MARK: - ReportView
            VStack(alignment: .leading) {
                ZStack(){
                    HStack(alignment:.top){
                        HStack{
                            Spacer()
                            Text("의류수거함 신고")
                                .bold()
                            Spacer()
                        }
                        .padding(.bottom, 18)
//                        .padding(.top, 10)
                        Button(action: { isShowingReportView = false }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
//                        .padding(.top, 10)
                    }
                    .padding(.horizontal,20)
                }
                VStack(alignment:.leading){
                    Text("신고 사유를 입력해주세요.")
                        .bold()
                    VStack{
                        ReportButtonView(label: "의류수거함이 이 위치에 없습니다.", isSelected: $selectedButtonLabel, pressedReportButton: $isShowingReportCheckView)
                        ReportButtonView(label: "의류수거함을 사용할 수 없는 상태입니다.", isSelected: $selectedButtonLabel, pressedReportButton: $isShowingReportCheckView)
                        // You can add more buttons here if needed
                    }
                    Spacer()
                }
                .padding(.horizontal,20)
            }
            .background(.white)
            
            .fullScreenCover(isPresented: $isShowingReportCheckView) {
                ReportCheckView(pressedReportButton: $pressedReportButton, isShowingReportView: $isShowingReportCheckView)
//                    .transition(.opacity)
                    .transition(.scale)

            }
           
        }
    }
}

struct ReportButtonView: View {
    let label: String
    @Binding var isSelected: String?
    @Binding var pressedReportButton: Bool
    
    var body: some View {
        Button(action: {
            isSelected = label
            pressedReportButton = true

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
        ReportView( isShowingReportView: .constant(true))
    }
}
