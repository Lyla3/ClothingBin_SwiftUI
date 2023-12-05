//
//  GuideView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/11/21.
//

import SwiftUI
import Combine

class TimerClass: ObservableObject {
    private var timer: AnyCancellable?
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                // Your timer logic here
            }
    }
    
    func stopTimer() {
        timer?.cancel()
    }
}

struct GuideView: View {
    let guideDataSet: imageDataSet = imageDataSet()
//    @ObservedObject var timerManager = TimerClass()
        private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var index = 1
    private let images: [String] = ["currentLocationImage1", "currentLocationImage2", "currentLocationImage3","currentMapImage1","currentMapImage2","regionSelectImage1","regionSelectImage2","regionSelectImage3"]
    private let guiedText: [String] = ["의류수거함 검색 가이드","현재위치 검색 버튼입니다.", "터치 1번: 현재 내 위치로 이동\n터치 2번: 내 위치 근처 의류수거함 표시","2. 현재 지도 검색","현재지도의 의류수거함을 검색할 수 있습니다.","3. 지역구별 검색","지역구를 선택해주세요.","선택된 지역구의 의류수거함을 볼 수 있습니다."]
    @State private var selectedImageName: String = ""
    
    @State var isShowingGuide: Bool = true
    @State var isStopedtimer: Bool = false
    
    var body: some View {
        VStack{
            VStack(alignment: .center) {
                ZStack{
                    HStack {
                        Spacer()
                        Button(action: { isShowingGuide = false }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                    }
                    HStack {
                        Text("사용 방법")
                            .font(.title3)
                    }
                }
                .padding(.horizontal,10)
                ZStack(alignment: .bottomTrailing){
                    VStack{
                        HStack{
                            Spacer()
                            Image(guideDataSet.imagesAndTexts[index - 1].image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: CGFloat.screenHeight*0.7)
                            Spacer()
                        }
                        Text("\(guideDataSet.imagesAndTexts[index - 1].text)")
                            .frame(height: CGFloat.screenHeight*0.075)
                    }
                }
            }
            //        lineSpacing(10.0)
            Spacer()
            //MARK: - <>버튼
            HStack{
                Button {
                    index = index > 1 && index <= images.count ? index - 1 : images.count
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30,height: 30)
                }
                .buttonStyle(.borderedProminent)
                .tint(.middleGrayColor)
                Text(" ")
                Button {
                    index = index < images.count ? index + 1 : 1
                } label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30,height: 30)
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.middleGrayColor)
            }
            .onReceive(timer, perform: { _ in
                withAnimation {
                    // index값을 증가, 아니면 1
                    // (selectedNum의 값을 변경해주기 위함)
                    
                    if isStopedtimer {
                        
                    } else {
                        index = index < guideDataSet.images.count - 1 ? index + 1 : 1
                        // selectedNum 값은 images 배열의 element 값
                        
                    }
                }
            })
            Spacer()
        }
    }
}

#Preview {
    GuideView()
}
