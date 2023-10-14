//
//  Coordinator.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import SwiftUI
import NMapsMap

//MARK: - Coordinator: NaverMap 담당 코디네이터
final class Coordinator: NSObject, ObservableObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
    
    static let shared = Coordinator()
    
    let view = NMFNaverMapView(frame: .zero)
    
    var clothingBinStore: ClothingBinStore = ClothingBinStore()
    
    var markers: [NMFMarker] = []
    var bookMarkedMarkers: [NMFMarker] = []
    var locationManager: CLLocationManager?
    
    @Published var isShowingLocationPermissionAlert: Bool = false
    @Published var isShowingMarkerEmptyGuiedView: Bool = false

    @Published var currentMarkerAddress: String = "주소"
    @Published var isShowingBinDetailView: Bool = false
    @Published var isBookMarkTapped: Bool = false
    @Published var showMarkerDetailView: Bool = false
    @Published var coord: NMGLatLng = NMGLatLng(lat: 0, lng: 0) // 현재 위치
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    @Published var currentScreenCoord: NMGLatLng = NMGLatLng(lat: 0, lng: 0) // 현재 위치
    @Published var isShowingZoomlevelGuide: Bool = false // 줌 레벨
    @Published var zoomlevelGuide: Double = 10 // 줌 레벨
    
    private override init() {
        super.init()
        
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.isNightModeEnabled = true
        view.showScaleBar = false
        // MARK: - 줌 레벨 제한
        view.mapView.zoomLevel = 15 // 기본 카메라 줌 레벨
        view.mapView.minZoomLevel = 12 // 최소 줌 레벨
        view.mapView.maxZoomLevel = 17 // 최대 줌 레벨
        // MARK: - 현 위치 추적 버튼
        view.showLocationButton = false
        view.showCompass = false
        
        // MARK: - NMFMapViewCameraDelegate를 상속 받은 Coordinator 클래스 넘겨주기
        view.mapView.addCameraDelegate(delegate: self)
        
        // MARK: - 지도 터치 시 발생하는 touchDelegate
        view.mapView.touchDelegate = self
        
        isShowingLocationPermissionAlert = false
        
    }
    
    deinit {
        print("Coordinator deinit!")
    }
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.checkLocationAuthorization()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn i on.")
            }
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
            //현재위치로 좌표 설정
            coord = NMGLatLng(lat: 37.49802240010302, lng: 127.0278532389088)
            fetchDefaultLocation()
        case .denied:
            print("You have denied this app location permission. Go into setting to change it.")
            //현재위치로 좌표 설정
            coord = NMGLatLng(lat: 37.49802240010302, lng: 127.0278532389088)
            fetchDefaultLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Success")
            //현재위치로 좌표 설정
            coord = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0.0, lng: locationManager.location?.coordinate.longitude ?? 0.0)
            print("LocationManager-coord: \(coord)")
            userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-userLocation: \(userLocation)")
            fetchUserLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    // NaverMapView를 반환
    func getNaverMapView() -> NMFNaverMapView {
        view
    }
    
    func makeMarkers() {
        for shopMarker in clothingBinStore.clothingBinArray {
            
            DispatchQueue.global(qos: .default).async {
                let marker = NMFMarker()
                
                marker.position = shopMarker.coord
                marker.captionRequestedWidth = 100 // 마커 캡션 너비 지정
                marker.captionText = shopMarker.info
                marker.captionMinZoom = 10
                marker.captionMaxZoom = 17
                marker.iconImage = NMFOverlayImage(name: "placeholder")
                marker.width = CGFloat(40)
                marker.height = CGFloat(40)
                
                self.markers.append(marker)
            }
            
            DispatchQueue.main.async {
                for marker in self.markers {
                    marker.mapView = self.view.mapView
                }
            }
            markerTapped()
        }
    }
    
    func makeMarkers(by bins: [ClothingBin]) {
        for bin in bins {
            let marker = NMFMarker()
            
            marker.position = bin.coord
            marker.captionRequestedWidth = 100 // 마커 캡션 너비 지정
            marker.captionText = bin.address
            marker.captionMinZoom = 15
            marker.iconImage = NMFOverlayImage(name: "placeholderGreen")
            marker.width = CGFloat(35)
            marker.height = CGFloat(35)
            
            markers.append(marker)
        }
        
        for marker in markers {
            marker.mapView = view.mapView
        }
        markerTapped()
    }
    
    func removeMarkers() {
        for marker in markers {
            marker.mapView = nil
        }
        markers.removeAll()
    }
    
    //유저의 위치 받아오기
    func fetchUserLocation() {
        if let locationManager = locationManager {
            let lat = locationManager.location?.coordinate.latitude
            let lng = locationManager.location?.coordinate.longitude
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0))
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            
            // MARK: - 현재 위치 좌표 overlay 마커 표시
            let locationOverlay = view.mapView.locationOverlay
            locationOverlay.location = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
            locationOverlay.hidden = false
            
            view.mapView.moveCamera(cameraUpdate)
        }
    }
    
    //위치권한 비허용시
    func fetchDefaultLocation() {
        self.moveCameraPosition()
    }
    
    // MARK: - Mark 터치 시 이벤트 발생
    func markerTapped() {
        for marker in markers {
            marker.touchHandler = { [self] (overlay) -> Bool in
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: marker.position.lat, lng: marker.position.lng))
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 1
                self.view.mapView.moveCamera(cameraUpdate)
                self.showMarkerDetailView = true
                self.currentMarkerAddress = marker.captionText
                print("showMarkerDetailView : \(self.showMarkerDetailView)")
                print(currentMarkerAddress)
                marker.zIndex = 1
                self.isShowingBinDetailView = true
                return true
            }
            marker.mapView = view.mapView
        }
    }
    
    // MARK: - 카메라 이동
    func moveCameraPosition() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        Coordinator.shared.view.mapView.moveCamera(cameraUpdate)
    }
    
    // MARK: - 지도 터치에 이용되는 Delegate
    /// 지도 터치 시 MarkerDetailView 창 닫기
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        showMarkerDetailView = false
    }
    
    // MARK: - 지도 중심 위치 확인에 이용되는 Delegate
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        currentScreenCoord = mapView.cameraPosition.target
        if view.mapView.zoomLevel < 14.5 {
            changemarkers()
        }
        else {
            changeCloseMarkers()
        }
        
    }
    
    func changemarkers() {
        for marker in self.markers {
            marker.iconImage = NMFOverlayImage(name: "Ellipse 2")
            marker.width = CGFloat(12)
            marker.height = CGFloat(12)

        }
    }
    func changeCloseMarkers() {
        for marker in self.markers {
            marker.iconImage = NMFOverlayImage(name: "placeholderGreen")
            marker.width = CGFloat(35)
            marker.height = CGFloat(35)
        }
    }
    
    func moveCameraToCenter() {
        let markers = self.markers
        
        guard !markers.isEmpty else { return }
            
            var totalLat: Double = 0.0
            var totalLng: Double = 0.0
            var weightSum: Double = 0.0
            
            for marker in markers {
                let position = marker.position
                
                let weight = pow(2, -Double(markers.count))
                
                totalLat += position.lat * weight
                totalLng += position.lng * weight
                weightSum += weight
            }
            
            let centerLatitude = totalLat / weightSum
            let centerLongitude = totalLng / weightSum
        DispatchQueue.main.async {
            self.view.mapView.zoomLevel = 12
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: centerLatitude, lng: centerLongitude))
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            
            self.view.mapView.moveCamera(cameraUpdate)
        }
    }
}
