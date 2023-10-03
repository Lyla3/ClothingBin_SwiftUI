//
//  MapView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import SwiftUI
import NMapsMap

struct MapView: View {
    
    @State var isShowingZoomlevelGuide: Bool = false
    @State var isShowingRegionSelectionView: Bool = false
    
    var body: some View {
        ZStack(alignment:.topTrailing) {
            NaverMap().ignoresSafeArea()
            HStack{
                Button {
                    Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentLocation)
                } label: {
                    Image("crosshair")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22)
                        .padding(8)
                        .background(.white)
                        .cornerRadius(20)
                }
                .position(x:UIScreen.main.bounds.width - 34, y: 32)
            }
            HStack{
                Button {
                    if Coordinator.shared.view.mapView.zoomLevel >= 13 {
                        Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentMap)
                    } else {
                        isShowingZoomlevelGuide = true
                    }
                } label: {
                    Text("현 지도에서 검색")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .padding(10)
                        .padding(.horizontal,7)
                        .background(
                            Rectangle()
                                .fill(.white)
                                .cornerRadius(20)
                        )
                        .padding()
                    
                }
                .position(x:UIScreen.main.bounds.width / 2, y: 32)
                
            }
            Button {
                // 지역선택 뷰 올라오게
                isShowingRegionSelectionView.toggle()
            } label: {
                Text("지역선택")
                    .font(.body)
                    .frame(width:  UIScreen.main.bounds.width - 21)
                    .background(
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.main.bounds.width - 21, height: 45)
                            .cornerRadius(10)
                    )
                    .foregroundColor(.black)
                    .padding()
                
            }
            .position(x:UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height - 120)
            
            if isShowingRegionSelectionView {
                Color.black.opacity(0.4)
                    .onTapGesture {
                        isShowingRegionSelectionView.toggle()
                    }
                    .ignoresSafeArea()
                
                VStack {
                    RegionSelectionView(isShowingModal: $isShowingRegionSelectionView)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .frame(maxHeight: .infinity)
                }
                .transition(.move(edge: .bottom))
            }
            if isShowingZoomlevelGuide && Coordinator.shared.view.mapView.zoomLevel < 13 {
                ZoomLevelGuideView()
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 200)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                            isShowingZoomlevelGuide = false
                            print("\(isShowingZoomlevelGuide)")
                        }
                        print("zoomLevel < 13")
                    }
            }
        }
        .zIndex(1)
        .onAppear{
            Coordinator.shared.checkIfLocationServicesIsEnabled()
            Coordinator.shared.moveCameraPosition()
            Coordinator.shared.makeMarkers()
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
