//
//  MapView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import SwiftUI
import NMapsMap

struct MapView: View {
    
    
    //    @ObservedObject var clothingBinStore: ClothingBinStore = ClothingBinStore()
    
    //@State private var coord: NMGLatLng = NMGLatLng(lat: 36.444, lng: 127.332)
    @State var isShowingZoomlevelGuide: Bool = Coordinator.shared.isShowingZoomlevelGuide
    
    var body: some View {
        ZStack(alignment:.topTrailing) {
            NaverMap().ignoresSafeArea()
            HStack{
                Button {
                    Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentLocation)
                } label: {
                    Text("현재위치")
                        .background(
                            Rectangle()
                                .fill(.white)
                        )
                        .padding()
                }
            }
            HStack{
                Button {
                    Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentMap)
                } label: {
                    Text("현재 지도")
                        .background(
                            Rectangle()
                                .fill(.white)
                        )
                        .padding()
                }
                .position(x:350, y:80)
               
            }
            if isShowingZoomlevelGuide {
                ZoomLevelGuideView()
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 200)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                            isShowingZoomlevelGuide = false
                        }
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
