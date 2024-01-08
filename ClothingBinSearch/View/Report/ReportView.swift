import SwiftUI

struct ReportView: View {
    @State private var selectedButtonLabel: String? = nil
    @State var pressedReportButton: Bool = false
    @Binding var isShowingReportView: Bool
    @State var isShowingReportCheckView: Bool = false
    
    @EnvironmentObject var reportBinData: ReportBinData
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack{
            //MARK: - ReportCheckView
//            if pressedReportButton{
//                ReportCheckView(pressedReportButton: $pressedReportButton, isShowingReportView: $isShowingReportView)
//            }
            //MARK: - ReportView
            VStack(alignment: .leading) {
                ZStack(){
                    HStack{
                        Spacer()
                        Button(action: {
                            print("ReportView Xmark Button pressed.")
                            print("selectedBinData.isShowingReportView:\(reportBinData.isShowingReportView)")
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                    }
                    .padding()
                    HStack{
                        Text("의류수거함 신고")
                    }
//                        .font(.title3)
                }
                VStack(alignment:.leading){
                    Text("신고 사유를 입력해주세요.")
                        .bold()
                    VStack{
                        ReportButtonView(label: "의류수거함이 이 위치에 없습니다.", selectedButtonLabel: $selectedButtonLabel, pressedReportButton: $reportBinData.isShowingReportCheckView)
                        ReportButtonView(label: "의류수거함을 사용할 수 없는 상태입니다.", selectedButtonLabel: $selectedButtonLabel, pressedReportButton: $reportBinData.isShowingReportCheckView)
                    }
                    Spacer()
                }
                .padding(.horizontal,20)
            }
            .background(.white)
            
            //MARK: - ReportCheckView 띄움
            .fullScreenCover(isPresented: $reportBinData.isShowingReportCheckView) {
                ReportCheckView(
                    isShowingReportView: $reportBinData.isShowingReportView, isShowingReportCheckView: $reportBinData.isShowingReportCheckView, selectedButtonLabel: $selectedButtonLabel)
//                    .transition(.scale)
            }.transition(.opacity)
           
        }
        .onDisappear{
            reportBinData.isShowingReportView = false
        }
    }
}

struct ReportButtonView: View {
    let label: String
    @Binding var selectedButtonLabel: String?
    @Binding var pressedReportButton: Bool
    @State private var isActive = false
    
    var body: some View {
        Button(action: {
            selectedButtonLabel = label
            pressedReportButton = true
            isActive = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isActive = false
                    }
        }) {
            HStack {
                Text(label)
                Spacer()
                Image(systemName: "chevron.forward")
            }
            .foregroundStyle(.black)
            .padding(.vertical, 10)
            .background(isActive ? Color.gray.opacity(0.3) : Color.clear)
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView( isShowingReportView: .constant(true))
    }
}
