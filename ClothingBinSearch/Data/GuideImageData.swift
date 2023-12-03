//
//  GuideImageData.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/11/25.
//

import Foundation

struct imageDataSet {
    let images: [String] = ["currentLocationImage1", "currentLocationImage2", "currentLocationImage3","currentMapImage1","currentMapImage2","regionSelectImage1","regionSelectImage2","regionSelectImage3"]
    let guiedText: [String] = ["의류수거함 검색 가이드","현재위치 검색 버튼입니다.", "터치 1번: 현재 내 위치로 이동\n터치 2번: 내 위치 근처 의류수거함 표시","2. 현재 지도 검색","현재지도의 의류수거함을 검색할 수 있습니다.","3. 지역구별 검색","지역구를 선택해주세요.","선택된 지역구의 의류수거함을 볼 수 있습니다."]
    
    struct ImageAndText: Hashable {
        let image: String
        let text: String
    }

    let imagesAndTexts: [ImageAndText] = [
        ImageAndText(image: "currentLocationImage1", text: "의류수거함 검색 가이드"),
        ImageAndText(image: "currentLocationImage2", text: "현재위치 검색 버튼입니다."),
        ImageAndText(image: "currentLocationImage3", text: "터치 1번: 현재 내 위치로 이동\n터치 2번: 내 위치 근처 의류수거함 표시"),
        ImageAndText(image: "currentMapImage1", text: "2. 현재 지도 검색"),
        ImageAndText(image: "currentMapImage2", text: "현재지도의 의류수거함을 검색할 수 있습니다."),
        ImageAndText(image: "regionSelectImage1", text: "3. 지역구별 검색"),
        ImageAndText(image: "regionSelectImage2", text: "지역구를 선택해주세요."),
        ImageAndText(image: "regionSelectImage3", text: "선택된 지역구의 의류수거함을 볼 수 있습니다.")
    ]
}
