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
                }
                    HStack {
                        Text("지역선택")
                            .font(.title2)
                    }
            }
            .padding()
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
