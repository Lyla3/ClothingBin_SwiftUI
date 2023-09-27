//
//  MapView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import SwiftUI
import NMapsMap

struct MapView: View {
    //

//    @ObservedObject var clothingBinStore: ClothingBinStore = ClothingBinStore()

    //@State private var coord: NMGLatLng = NMGLatLng(lat: 36.444, lng: 127.332)
    var body: some View {
        ZStack(alignment:.topTrailing) {
            NaverMap().ignoresSafeArea()
//            Button(action: {
//                Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentLocation)
////                clothingBinStore.handleButtonTap(buttonType: .currentLocation)
//                        }) {
//                            Text("현재위치버튼")
//                        }
            Button {
                Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentLocation)
            } label: {
                Text("현재위치버튼")
                    .background(
                        Rectangle()
                            .fill(.white)
                    )
                    .padding()
            }

        }
        .zIndex(1)
        .onAppear{
            Coordinator.shared.checkIfLocationServicesIsEnabled()
            //Coordinator.shared.userDataStore.user = userDataStore.user
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
