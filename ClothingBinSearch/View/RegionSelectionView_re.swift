//
//  RegionSelectionView_re.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2024/01/10.
//

import SwiftUI

struct RegionSelectionView_re: View {
//    @State private var selectedDistrict = 0
    @State private var selectedDistrict =  Region.Gangnam

    
    @Binding var isShowingModal: Bool
    @Binding var analyticsStore: AnalyticsStore
    
    let districts = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]

    var body: some View {
        VStack {
//            Text("선택한 지역구: \(districts[selectedDistrict])")
            Picker(selection: $selectedDistrict, label: Text("지역구 선택")) {
                ForEach(Region.allCases, id: \.self) { region in
                    // 출력
                    Text(region.rawValue)
                }
            }.pickerStyle(.menu)
            Text("선택된 파일 이름: \(selectedDistrict.getFileName())")
        }
    }
}

#Preview {
    RegionSelectionView_re(isShowingModal: .constant(false), analyticsStore: .constant(AnalyticsStore()))
}
