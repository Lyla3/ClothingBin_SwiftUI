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
            Text("서울 강남")
            Text("서울 강남")
            Text("서울 강남")
            Text("서울 강남")
            Text("서울 강남")
            Text("서울 강남")
            Text("서울 강남")
        }
    }
}

struct RegionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionSelectionView(isShowingModal: .constant(false))
    }
}
