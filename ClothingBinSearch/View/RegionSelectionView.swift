//
//  RegionSelectionView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/02.
//

import SwiftUI

struct RegionSelectionView: View {
    @Binding var isShowingModal: Bool
    
    var body: some View {
        VStack {
            ZStack{
                HStack {
                    Spacer()
                    Button(action: { isShowingModal = false }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                }
                    HStack {
                        Text("지역선택")
                            .font(.title2)
                    }
                
            }
            .padding()
            
            ForEach(Region.allCases, id: \.self) { region in
                Button(action: {
                    // 버튼이 클릭되었을 때 수행할 동작
                    print("Selected Region:", region.rawValue)
                    Coordinator.shared.clothingBinStore.selectedRegion = region
                    Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .region)
                    isShowingModal = false
                }) {
                    Text(region.rawValue)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬을 위해 alignment 추가
                }
                Divider()
            }
        }
    }
}


struct RegionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionSelectionView(isShowingModal: .constant(false))
    }
}
