//
//  NaverMap.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import SwiftUI
import NMapsMap
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift

struct NaverMap: UIViewRepresentable {
    // 데이터 
    //    @EnvironmentObject var userDataStore: UserStore
    //    @EnvironmentObject var shopDataStore: ShopDataStore
    
    //    @Binding var coord: (Double, Double)
    //    @Binding var userLocation: (Double, Double)
    //    @Binding var isBookMarkTapped: Bool
    
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    //        init(coord: Binding<(Double, Double)>, showMarkerDetailView: Binding<Bool>, currentShopId: Binding<String>, userLocation: Binding<(Double, Double)>, isBookMarkTapped: Binding<Bool>
    //        ) {
    //            self._coord = coord
    //            self._showMarkerDetailView = showMarkerDetailView
    //            self._currentShopId = currentShopId
    //            self._userLocation = userLocation
    //            self._isBookMarkTapped = isBookMarkTapped
    //        }
    //
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //        let coord = NMGLatLng(lat: Coordinator.shared.coord.0, lng: Coordinator.shared.coord.1)
        //        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        //        cameraUpdate.animation = .fly
        //        cameraUpdate.animationDuration = 1
        //        uiView.mapView.moveCamera(cameraUpdate)
    }
}
