//
//  SimpleRadioButton.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/12/11.
//

import SwiftUI

struct ReportBinRadioButton: View {

    @Binding var value: Bool
    @State var selectedNum: String = ""
    @State var selectedNumArray: [String] = ["이 위치에 의류수거함이 없습니다.","주소와 지도상의 위치가 다릅니다."]

    var body: some View {
        VStack{
            HStack{
                Button {
                    //
                } label: {
                    Text("취소")
                }
                Spacer()
                Text("의류수거함 오류 신고")
                Spacer()
                Button {
                    //
                } label: {
                    Text("제출")
                    
                }
            }
            Spacer()
            ForEach(selectedNumArray.indices, id: \.self) { index in
                let reportReason = selectedNumArray[index]
                Button(action: {
                    selectedNum = reportReason
                    value.toggle()
                }) {
                    Image(systemName: value && selectedNum == reportReason ? "checkmark.circle.fill" : "circle")
                    Text(reportReason)
                        .foregroundStyle(.black)
                }
            }
            Spacer()
        }
        .padding(10)
    }
    
}

#Preview {
    ReportBinRadioButton(value: .constant(true))
}
