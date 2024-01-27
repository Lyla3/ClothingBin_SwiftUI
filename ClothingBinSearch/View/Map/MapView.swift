//
//  MapView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import SwiftUI
import NMapsMap

struct MapView: View {
    @StateObject var coordinator: Coordinator = Coordinator.shared
    @State var isShowingZoomlevelGuide: Bool = false
    @State var isShowingRegionSelectionView: Bool = false
    @State var isShowingGuideView: Bool = false
    @State private var uniqueUserID: String = ""
    @State var analyticsStore: AnalyticsStore = AnalyticsStore()
    
    @EnvironmentObject var reportBinData: ReportBinData
    
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
                        .padding(13)
                        .background(.white)
                        .cornerRadius(30)
                        .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                }
                .position(x: 38, y:UIScreen.main.bounds.height - 200)
                
               
            }
            Button {
                // GuideView 띄우기
                isShowingGuideView = true
            } label: {
                Image(systemName: "questionmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14,height: 14)
                    .padding(13)
                    .background(.white)
                    .cornerRadius(90)
                    .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .position(x: CGFloat.screenWidth - 35, y:32)
//            HStack{
//                Button {
//                    Coordinator.shared.clothingBinStore.handleButtonTap(buttonType: .currentLocation)
//                } label: {
//                                        Image(systemName: "questionmark.circle")
//                        .resizable()
//                        .foregroundStyle(.gray)
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 22, height: 22)
//                        
//                        .padding(8)
//                        .background(.white)
//                        .cornerRadius(20)
//                        .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
//                }
//                .position(x:UIScreen.main.bounds.width - 34, y: 32)
//            }
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
                                .cornerRadius(20)                .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                        )
                        .padding()
                    
                }
                .position(x:UIScreen.main.bounds.width / 2, y: 32)
                
            }
            Button {
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
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    )
                    .foregroundColor(.black)
                    .padding()
                
            }
            .position(x:UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height - 120)
            
            
            if isShowingGuideView {
                Color.black.opacity(0.4)
                    .onTapGesture {
                        isShowingGuideView.toggle()
                    }
                    .ignoresSafeArea()
                VStack {
                   GuideView(isShowingGuide: $isShowingGuideView)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .frame(maxHeight: .infinity)
                }
                .transition(.move(edge: .bottom))
            }
            
            if isShowingRegionSelectionView {
                Color.black.opacity(0.4)
                    .onTapGesture {
                        isShowingRegionSelectionView.toggle()
                    }
                    .ignoresSafeArea()
                VStack {
                    RegionSelectionView(isShowingModal: $isShowingRegionSelectionView, analyticsStore: $analyticsStore)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .frame(maxHeight: .infinity)
                }
                .transition(.move(edge: .bottom))
            }
            //MARK: - ZoomLevel이 작은 경우 안내창
            if isShowingZoomlevelGuide && Coordinator.shared.view.mapView.zoomLevel < 13 {
                ZoomLevelGuideView()
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 200)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                            isShowingZoomlevelGuide = false
                        }
                    }
            }
            //MARK: - 검색된 의류수거함이 없는 경우 안내창
            if coordinator.isShowingMarkerEmptyGuiedView {
                MarkerEmptyGuideView()
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 200)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                            coordinator.isShowingMarkerEmptyGuiedView = false
                            print("isShowingMarkerEmptyGuiedView:\(coordinator.isShowingMarkerEmptyGuiedView)")
                        }
                    }
            }
            //MARK: - 의류수거함 아이콘 클릭시 상세정보 보기
            if coordinator.isShowingBinDetailView {
                BinDetailView(screenWidth: (UIScreen.main.bounds.width), isShowingBinDetailView: $coordinator.isShowingBinDetailView, currentMarkerAddress: $coordinator.currentMarkerAddress)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 150)
            }
        }
        .alert(isPresented: $coordinator.isShowingLocationPermissionAlert) {
                    Alert(
                        title: Text("위치 권한 허용"),
                        message: Text("설정>의류수거함 검색 에서 위치 서비스를 허용하시면 현재위치 의류수거함 정보를 보실 수 있습니다."),
                        primaryButton: .default(Text("설정하기"), action: openSettings),
                        secondaryButton: .cancel()
                    )
                }
        .zIndex(1)
        .onAppear{
            Coordinator.shared.checkIfLocationServicesIsEnabled()
            Coordinator.shared.moveCameraPosition()
            Coordinator.shared.makeMarkers()
            print("coordinator.showingLocationPermissionAlert:\(coordinator.isShowingLocationPermissionAlert)")
        }
    }
    
    func openSettings() {
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        coordinator.isShowingLocationPermissionAlert = false
        }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
