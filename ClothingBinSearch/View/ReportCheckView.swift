//
//  MarkerEmptyGuiedView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/12.
//

import SwiftUI

struct ReportCheckView: View {
    @Binding var pressedReportButton: Bool
    @Binding var isShowingReportView: Bool
    @Binding var isShowingReportCheckView: Bool
    @Binding var selectedButtonLabel: String?
    @EnvironmentObject var selectedBinData: SelectedBinData
    
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
                    print("\(selectedBinData.binData)")
                    print("buttonLabel:\(String(describing: selectedButtonLabel))")
                    // 창 닫기
                    isShowingReportView = false
                    isShowingReportCheckView = false
                    pressedReportButton = false
                } label: {
                    Spacer()
                    Text("신고하기")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                Button{
                    //
                    isShowingReportCheckView = false
                    pressedReportButton = false
                } label: {
                    Spacer()
                    Text("취소")
                    Spacer()

                }
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
        ReportCheckView(pressedReportButton: .constant(false), isShowingReportView: .constant(false), isShowingReportCheckView: .constant(true), selectedButtonLabel: .constant("selectedButtonLabel"))
    }
}