//
//  RegionSelectionView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/02.
//

import SwiftUI
//import FirebaseAnalytics


struct RegionSelectionView: View {
    @Binding var isShowingModal: Bool
    @Binding var analyticsStore: AnalyticsStore
    
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
                        .frame(maxHeight: 50, alignment: .top)
                }
                    HStack {
                        VStack(spacing: 5){
                            Text("의류수거함 검색 지역 선택")
                                .font(.title3)
                            Text("더 많은 지역 정보는 스크롤하여 주시기 바랍니다.")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
            }
            .padding(.top, 15)
            .padding(.horizontal, 10)
            ScrollView{
                ForEach(Region.allCases, id: \.self) { region in
                    Divider()
                    Button(action: {
                        print("Selected Region:", region.rawValue)
                        Coordinator.shared.clothingBinStore.selectedRegion = region
                        Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .region)
                        isShowingModal = false
                    }) {
                        Text(region.rawValue)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Divider()
            }
        }
        .onAppear {
//            analyticsStore.logEvent(itemName: "RegionView", contentType: "")
        }
    }
}


struct RegionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionSelectionView(isShowingModal: .constant(false), analyticsStore: .constant(AnalyticsStore()))
    }
}
