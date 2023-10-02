//
//  ClothingBInStore.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import Foundation
import CoreLocation
import NMapsMap

class ClothingBinStore: ObservableObject{
    @Published var clothingBinArray:[ClothingBin] = []
    @Published var currentButtonType: ButtonType = .none

    var clothingBinLocationArrayString: [[String]] = []      // String타입의 의류수거함 배열
    var selectedRegion: Region = .Gangnam
    private var currentLocationButtonCount = 0
    private var mapButtonSelected: Bool = false
    
    // 버튼 종류에 따라 메서드 실행
    //MARK: - 버튼 종류 받아오기
    func handleButtonTap(buttonType: ButtonType) {
        switch buttonType {
        case .currentLocation:
            if currentButtonType == .currentLocation && currentLocationButtonCount >= 1 || mapButtonSelected == false {
                // 현재 위치로 지도를 이동하는 기능 실행
                moveMapToCurrentLocation()
                
                // 현재 위치 1km 이내의 버튼을 불러오는 기능 실행
                loadButtonsNearCurrentLocation()
                
                currentLocationButtonCount = 1
            } else if currentButtonType != .currentLocation || (currentButtonType == .currentLocation && currentLocationButtonCount == 1)  || mapButtonSelected == true  {
                // 현재 위치로 지도만 이동하는 기능 실행
                moveMapToCurrentLocation()
                
                currentLocationButtonCount += 1
                mapButtonSelected = false
            }
            
            currentButtonType = buttonType
            
        case .currentMap:
            // 현재 화면의 마커들을 불러오는 기능 실행
            loadMarkersOnScreen()
            
            currentButtonType = buttonType
            mapButtonSelected = true
            
        case .region:
            // 지역구의 마커를 불러오는 기능 실행
            loadMarkersInDistrict()
            currentButtonType = buttonType
            mapButtonSelected = true
        default:
            break
        }
    }
    
    //MARK: - 현재위치로 지도 이동
    func moveMapToCurrentLocation() {
        // 현재 위치로 지도를 이동하는 로직 작성...
        
        print("현재 위치로 지도 이동")
        Coordinator.shared.fetchUserLocation()
        // 추가적인 로직 작성...
    }
    
    //MARK: - 1) 현재 위치 가까이의 의류수거함을 로드
    func loadButtonsNearCurrentLocation() {
        // 현재 위치 1km 이내의 버튼을 로드하는 로직 작성...
        print("현재 위치 1km 이내의 버튼 로드")
        
        clearBinArray()
        // 1) CSV -> ClothingBin으로 변환
        loadClothingBinFromAllCVS()
        // 2) 가까운 순서대로 (sort)
        // 3) 기준에 맞는 것 반환
        // 4) clothingBinArray 변경
        changeStringToClothingBin(from: clothingBinLocationArrayString)
        extractClothingBinsWithinDistance(clothingBinArray, maxDistance: 600)
        
        //5) 지도에 마커 추가
        Coordinator.shared.makeMarkers(by: clothingBinArray)
    }
    //MARK: - 2) 현재 화면의 의류수거함을 로드
    func loadMarkersOnScreen() {
        clearBinArray()
        // 현재 화면에 보이는 마커들을 로드하는 로직 작성...
        
        print("현재 화면의 마커들 로드")
        
        // 추가적인 로직 작성...
        
        // 1) CSV -> ClothingBin으로 변환
        loadClothingBinFromAllCVS()
        // 2) 화면안의 좌표 구하기($표시는 왜?)
        
        // 위 지점에서 distance 몇 미터 이내만 반환
        
        // 3) 화면안의 좌표에 들어오는 것만 반환
       
        // 4) clothingBinArray 변경
        changeStringToClothingBin(from: clothingBinLocationArrayString)
        extractClothingBinsWithinMap(clothingBinArray, maxDistance: 400)
//        extractClothingBinsWithinDistance(clothingBinArray, maxDistance: 1000)
        
        //5) 지도에 마커 추가
        Coordinator.shared.makeMarkers(by: clothingBinArray)
    }
    
    //MARK: - 3) 선택한 지역구의 의류수거함을 로드
    func loadMarkersInDistrict() {
        // 선택한 지역구의 마커들을 로드하는 로직 작성...
        clearBinArray()
        print("지역구 내 마커들 로드")
        
        // 추가적인 로직 작성...
        loadClothingBinFromRegionCVS()
        
        changeStringToClothingBin(from: clothingBinLocationArrayString)
        Coordinator.shared.makeMarkers(by: clothingBinArray)
    }
    
    //MARK: - ClothingBin 초기화
    func clearBinArray() {
        Coordinator.shared.removeMarkers()
        clothingBinArray = []
        clothingBinLocationArrayString = []
    }

    
    // MARK: - CVS -> ClothingBin 데이터 변환 함수
    func loadClothingBinFromAllCVS() {
        for resource in Region.allCases {
            let path = Bundle.main.path(forResource: resource.getFileName(), ofType: "csv") ?? "\(Region.Gangnam.getFileName())"
//            print("path: \(path)")
            parseCSVAt(url: URL(fileURLWithPath: path))
        }
    }
    
    func loadClothingBinFromRegionCVS() {
        let path = Bundle.main.path(forResource: selectedRegion.getFileName(), ofType: "csv") ?? "\(Region.Gangnam.getFileName())"
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
    
    //MARK: - 엑셀 파일 파싱 함수
    private func parseCSVAt(url:URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                for item in dataArr {
                    // 변환 값 나누어서 배열에 넣기
                    clothingBinLocationArrayString.append(item)
//                    print("item:\(item)")
                    
                }
//                print("item:\(clothingBinLocationArray)")
//                print("array.count:\(clothingBinArray.count)")

            }
        } catch {
            print("Error reading CVS file.")
        }
    }
    
    func changeStringToClothingBin(from clothinBinStringArray:[[String]]) {
        var currentMapPonitArray : [ClothingBin] = []
        
        for clothingBox in clothinBinStringArray {
            let clothingBoxInfo = clothingBox[0]
            let clothingBoxLat = Double(clothingBox[1]) ?? 0.0
            let clothingBoxLon = Double(clothingBox[2].replacingOccurrences(of: "\r", with: "")) ?? 0.0
            clothingBinArray.append(ClothingBin(address: clothingBoxInfo, coord: NMGLatLng(lat:clothingBoxLat,lng:clothingBoxLon), addressDetail: "", info: ""))
        }
    }
    
    // clothingBinLocationArray 받아오기
//    private func loadClothingBinCloseCurrentLocation(from cvsArray:[[String]]) {
//        for clothingBin in clothingBinArray {
//            distance(clothingBin.coord.lat, clothingBin.coord.lng)
//        }
//
//        let newClothingBin =
//        clothingBinArray.sorted {
//            let distance1 = distance($0.coord.lat, $0.coord.lng)
//            let distance2 = distance($1.coord.lat, $1.coord.lng)
//            return distance1 < distance2
//        }
//
//    }
//
    
    //MARK: - 유저와의 거리가 가까운 의류수거함만 남김
    private func extractClothingBinsWithinDistance(_ bins: [ClothingBin], maxDistance: CLLocationDistance) {
//        print("\(clothingBinArray)")
        
        // 거리가 maxDistance 이내인지 확인하는 함수
        func isWithinMaxDistance(_ bin: ClothingBin) -> Bool {
            let binDistance = distanceWhitinCLocation(bin.coord.lat, bin.coord.lng)
//            print("binDistance:\(binDistance)")
            return binDistance <= maxDistance
        }
        
        // maxDistance 이내인 ClothingBin 추출 후 거리 순으로 정렬하여 반환
        let extractedBins = bins
            .filter { isWithinMaxDistance($0) }
                                .sorted {
                                    let distance1 = distanceWhitinCLocation($0.coord.lat, $0.coord.lng)
                                    let distance2 = distanceWhitinCLocation($1.coord.lat, $1.coord.lng)
                                    return distance1 < distance2
                                }
        clothingBinArray = extractedBins
    }
    
    //MARK: - 유저와의 거리가 가까운 의류수거함만 남김
    private func extractClothingBinsWithinMap(_ bins: [ClothingBin], maxDistance: CLLocationDistance) {
//        print("\(clothingBinArray)")
        
        // 거리가 maxDistance 이내인지 확인하는 함수
        func isWithinMaxDistance(_ bin: ClothingBin) -> Bool {
            let binDistance = distanceWithinMapLocation(bin.coord.lat, bin.coord.lng)
//            print("binDistance:\(binDistance)")
            return binDistance <= maxDistance
        }
        
        // maxDistance 이내인 ClothingBin 추출 후 거리 순으로 정렬하여 반환
        let extractedBins = bins
            .filter { isWithinMaxDistance($0) }
                                .sorted {
                                    let distance1 = distanceWithinMapLocation(                $0.coord.lat, $0.coord.lng)
                                    let distance2 = distanceWithinMapLocation($1.coord.lat, $1.coord.lng)
                                    return distance1 < distance2
                                }
        clothingBinArray = extractedBins
    }
   
    
    // MARK: - 현재 위치에서부터 좌표까지 거리 계산 함수
    func distanceWhitinCLocation(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: Coordinator.shared.userLocation.0, longitude: Coordinator.shared.userLocation.1)
        return from.distance(from: to)
    }
    
    // MARK: - map 위치에서부터 좌표까지 거리 계산 함수
    func distanceWithinMapLocation(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: Coordinator.shared.currentScreenCoord.lat, longitude: Coordinator.shared.currentScreenCoord.lng)
        return from.distance(from: to)
    }
}


