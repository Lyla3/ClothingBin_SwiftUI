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
    @State var isShowingZoomlevelGuide: Double = Coordinator.shared.view.mapView.zoomLevel
    @State var isShowingRegionSelectionView: Bool = false
    
//    @ObservedObject var zoomLevelObserver = ZoomLevelObserver()

    
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
                .position(x:350, y:40)
            }
            HStack{
                Button {
                    Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentMap)
                } label: {
                    Text("현 지도에서 검색")
                        .foregroundColor(.black)
                        .padding(10)
                        .padding(.horizontal,7)
                        .background(
                            Rectangle()
                                .fill(.white)
                                .cornerRadius(20)
//                                .padding(.horizontal,100)
                        )
                        .padding()

                }
                .position(x:UIScreen.main.bounds.width / 2, y:40)
               
            }
            Button {
                // 지역선택 뷰 올라오게
                isShowingRegionSelectionView.toggle()
            } label: {
                Text("지역선택")
                    .font(.title3)
                    .background(
                        Rectangle()
                            .fill(.white)
                            .frame(width: 350, height: 45)
                            .cornerRadius(13)
                    )
                    .foregroundColor(.black)
                    .padding()
            }
            .position(x:UIScreen.main.bounds.width / 2, y:700)
            
            if isShowingRegionSelectionView {
                Color.black.opacity(0.4)
                    .onTapGesture {
                        // Dismiss the region selection view when tapping outside
                        isShowingRegionSelectionView.toggle()
                    }
                    .ignoresSafeArea()
                
                VStack {
//                    Spacer()
                    
                    // This is the content of your half-screen modal
                    RegionSelectionView(isShowingModal: $isShowingRegionSelectionView)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .frame(maxHeight: .infinity)
                }
                .transition(.move(edge: .bottom))
            }
//            if isShowingZoomlevelGuide < 15 {
//                ZoomLevelGuideView()
//                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 200)
//                    .onAppear {
//                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
////                            isShowingZoomlevelGuide = false
//                            print("\(isShowingZoomlevelGuide)")
//                        }
//                        print("zoomLevel < 12")
//                    }
//            }
//            HStack{
//                Text("Zoom Level: \(zoomLevelObserver.zoomLevel)")
//                    .onReceive(Coordinator.shared.$zoomlevelGuide) { newZoomLevel in
//                        // Handle changes to the zoom level here
//                        zoomLevelObserver.zoomLevel = newZoomLevel
//                    }
//            }
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
