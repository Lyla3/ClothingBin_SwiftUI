//
//  reportNoClothingBin.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/12/09.
//

import SwiftUI

struct ReportNoClothingBinView: View {
    @Binding var currentSeletedBinAddress: String
    @State private var buttonValue = false

//       var body: some View {
//       }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ReportBinRadioButton(value: $buttonValue)

                Button {
                    //
                } label: {
                    Text("닫기")
                }
                Spacer()
                Text("title")
                    .bold()
                Spacer()
                Button {
                    //
                } label: {
                    Text("제출")
                }
              
            }
            .padding(.bottom,10)
            Text("신고 사유를 선택해주세요")
            
            
        }
        .padding()
        
    }
}

#Preview {
    ReportNoClothingBinView(currentSeletedBinAddress: .constant("address"))
}
