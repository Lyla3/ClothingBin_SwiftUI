//
//  ClothingBInStore.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import Foundation

class ClothingBinStore: ObservableObject{
    @Published var clothingBinArray:[ClothingBin] = []
    @Published var currentButtonType: ButtonType = .none
    
    private var currentLocationButtonCount = 0

    // 버튼 종류에 따라
    func handleButtonTap(buttonType: ButtonType) {
           switch buttonType {
           case .currentLocation:
               if currentButtonType == .currentLocation && currentLocationButtonCount >= 2 {
                   // 현재 위치로 지도를 이동하는 기능 실행
                   moveMapToCurrentLocation()
                   
                   // 현재 위치 1km 이내의 버튼을 불러오는 기능 실행
                   loadButtonsNearCurrentLocation()
                   
                   currentLocationButtonCount = 1
               } else if currentButtonType != .currentLocation || (currentButtonType == .currentLocation && currentLocationButtonCount == 1) {
                    // 현재 위치로 지도만 이동하는 기능 실행
                    moveMapToCurrentLocation()
                    
                    currentLocationButtonCount += 1
                }
                
                currentButtonType = buttonType
               
           case .currentMap:
                // 현재 화면의 마커들을 불러오는 기능 실행
                loadMarkersOnScreen()
                
                currentButtonType = buttonType
               
           case .region:
                // 지역구의 마커를 불러오는 기능 실행
                loadMarkersInDistrict()
                
                currentButtonType = buttonType
           default:
               break
           }
       }
       
       func moveMapToCurrentLocation() {
           // 현재 위치로 지도를 이동하는 로직 작성...
           
           print("현재 위치로 지도 이동")
           
           // 추가적인 로직 작성...
       }
       
       func loadButtonsNearCurrentLocation() {
           // 현재 위치 1km 이내의 버튼을 로드하는 로직 작성...
           
           print("현재 위치 1km 이내의 버튼 로드")
           
           // 추가적인 로직 작성...
       }
       
       func loadMarkersOnScreen() {
            // 현재 화면에 보이는 마커들을 로드하는 로직 작성...
            
            print("현재 화면의 마커들 로드")
            
            // 추가적인 로직 작성...
        }
        
        func loadMarkersInDistrict() {
            // 선택한 지역구의 마커들을 로드하는 로직 작성...
            
            print("지역구 내 마커들 로드")
            
            // 추가적인 로직 작성...
        }
   }


