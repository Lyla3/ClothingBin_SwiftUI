//
//  reportNoClothingBin.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/12/09.
//

import SwiftUI

struct ReportNoClothingBin: View {
    @Binding var currentSeletedBinAddress: String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
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
    ReportNoClothingBin(currentSeletedBinAddress: .constant("address"))
}
