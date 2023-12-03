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
    @ObservedObject var timerManager = TimerClass()
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var index = 1
    private let images: [String] = ["currentLocationImage1", "currentLocationImage2", "currentLocationImage3","currentMapImage1","currentMapImage2","regionSelectImage1","regionSelectImage2","regionSelectImage3"]
    private let guiedText: [String] = ["의류수거함 검색 가이드","현재위치 검색 버튼입니다.", "터치 1번: 현재 내 위치로 이동\n터치 2번: 내 위치 근처 의류수거함 표시","2. 현재 지도 검색","현재지도의 의류수거함을 검색할 수 있습니다.","3. 지역구별 검색","지역구를 선택해주세요.","선택된 지역구의 의류수거함을 볼 수 있습니다."]
    @State private var selectedImageName: String = ""
    
    @State var isShowingGuide: Bool = true
    @State var isStopedtimer: Bool = false
    
    var body: some View {
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
               
                HStack{
                    Button {
                        print("button pressed")
                        if isStopedtimer == false{
                            isStopedtimer = true
                            timerManager.stopTimer()
                        } else {
                            isStopedtimer = false
                            timerManager.startTimer()
                            withAnimation {
                                index = index < images.count ? index + 1 : 1
                                // selectedNum 값은 images 배열의 element 값
                                selectedImageName = images[index - 1]
                            }
                        }
                    } label: {
                        Image(systemName: isStopedtimer ? "play.fill": "pause.fill")
                            .foregroundStyle(.black)
                    }
                }
                .background(.blue)
                .zIndex(1)
                
                HStack{
                    TabView(selection: $selectedImageName) {
                        // 인덱스로 넘기기
                        ForEach(guideDataSet.imagesAndTexts, id: \.self) { guideData in
                            VStack{
                                Image(guideData.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: CGFloat.screenWidth*0.7)
                                Text("\(guideData.text)")
                            }
                            
                        }
                    }
                    .tabViewStyle(.page)
                    // 이미지를 감싼 TabView의 크기
                    .frame( width: CGFloat.screenWidth*0.7, height: CGFloat.screenHeight * 0.655)
                    
                    .onReceive(timer, perform: { _ in
                        withAnimation {
                            // index값을 증가, 아니면 1
                            // (selectedNum의 값을 변경해주기 위함)
                            
                            if isStopedtimer {
                                
                            } else {
                                index = index < images.count ? index + 1 : 1
                                // selectedNum 값은 images 배열의 element 값
                                selectedImageName = images[index - 1]
                            }
                        }
                    })
                }
//                .background(.red)
            }
            //버튼: 일시정지
            //한번 눌리면 일시정지, 다시 눌리면 재생
                        HStack{
                            Button {
                                if isStopedtimer == false{
                                    isStopedtimer = true
                                } else {
                                    isStopedtimer = false
                                    withAnimation {
                                        
                                        index = index < images.count ? index + 1 : 1
                                        // selectedNum 값은 images 배열의 element 값
                                        selectedImageName = images[index - 1]
                                    }
                                }
                            } label: {
                                Image(systemName: isStopedtimer ? "play.fill": "pause.fill")
//                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.black)
                            }
                        }
            Text("\(guiedText[index - 1])")
                .frame(height: 50)
        }
        VStack{
            
        }
    }
}

#Preview {
    GuideView()
}
