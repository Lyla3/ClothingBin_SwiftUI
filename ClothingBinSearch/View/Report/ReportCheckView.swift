//
//  MarkerEmptyGuiedView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/12.
//

import SwiftUI

struct ReportCheckView: View {
    @Binding var isShowingReportView: Bool
    @Binding var isShowingReportCheckView: Bool
    @Binding var selectedButtonLabel: String?
    @State private var isDoneReported: Bool = false
    
    @EnvironmentObject var reportBinData: ReportBinData
    @State var reportBinStore: ReportBinStore = ReportBinStore()
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.black.opacity(0.5))
                .blur(radius: 2)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Text("신고하시겠습니까?")
                    .bold()
                    .padding(.vertical,7)
                Button{
                    // 신고하기 로직
                    reportBinStore.binAddress = reportBinData.binData
                    reportBinStore.uploadBin(reason: selectedButtonLabel ?? "")
                    
                    print("\(reportBinData.binData)")
                    print("buttonLabel:\(String(describing: selectedButtonLabel))")
                    
                  
                    
                    // 신고가 완료되었음을 표시
                    isDoneReported = true
                    
                    // 창 닫기
                    reportBinData.isShowingReportCheckView = false
                    reportBinData.isShowingReportView = false
                    
                        print("selectedBinData.isShowingReportView\(reportBinData.isShowingReportView)")
                    
                } label: {
                    Spacer()
                    Text("신고하기")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                Button{
                    isShowingReportCheckView = false
                } label: {
                    Spacer()
                    Text("취소")
                    Spacer()
                }
            }
            .alert(isPresented: $isDoneReported) {
                            Alert(title: Text("알림"), message: Text("신고가 정상적으로 처리되었습니다."), dismissButton: .default(Text("확인")))
                        }
                .foregroundColor(.black)
                .font(.body)
                .frame(width:300)
                .padding(.horizontal, 15)
                .padding(.vertical, 18)
                .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black.opacity(0.5))
                    .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white.opacity(0.7))
                )
                )
        }
    }
}

struct ReportCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ReportCheckView(isShowingReportView: .constant(false), isShowingReportCheckView: .constant(true), selectedButtonLabel: .constant("selectedButtonLabel"))
    }
}
