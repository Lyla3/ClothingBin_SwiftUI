//
//  RegionSelectionView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/02.
//

import SwiftUI

struct RegionSelectionView: View {
    
    @Binding var isShowingModal:Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("지역선택")
                Spacer()
                Button("Done") { isShowingModal = false }
            }
            Button {
                // 강남구 배열에 넣기
                Coordinator.shared.clothingBinStore.selectedRegion = .Gangnam
                Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .region)
            } label: {
                Text("서울 강남")
            }
            Button {
                // 강남구 배열에 넣기
                Coordinator.shared.clothingBinStore.selectedRegion = .Gongro
                Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .region)
            } label: {
                Text("서울 종로")
            }
        }
    }
}

struct RegionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionSelectionView(isShowingModal: .constant(false))
    }
}
