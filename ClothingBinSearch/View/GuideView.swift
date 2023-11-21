//
//  GuideView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/11/21.
//

import SwiftUI

struct GuideView: View {
    private let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    @State private var index = 1
    private let images: [String] = ["currentLocationImage1", "currentLocationImage2", "currentLocationImage3"]
    private let guiedText: [String] = ["현재위치 검색", "현재위치를 검색할 수 있습니다.", "터치 1번: 현재 내 위치\n터치 2번: 내 위치 근처 의류수거함 표시"]
    @State private var selectedNum: String = ""
    
    @State var isShowingGuide: Bool = true
    
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
            HStack{
                TabView(selection: $selectedNum) {
                    ForEach(images, id: \.self) {
                        // 이미지의 크기
                        Image($0)
                            .resizable()
                            .scaledToFit()
                            .frame(width: CGFloat.screenWidth*0.7)
                    }
                }
                .tabViewStyle(.page)
                // 이미지를 감싼 TabView의 크기
                .frame( width: CGFloat.screenWidth*0.7, height: CGFloat.screenHeight * 0.655)
                .border(.black)
                
                .onReceive(timer, perform: { _ in
                    withAnimation {
                        // index값을 증가, 아니면 1
                        // (selectedNum의 값을 변경해주기 위함)
                        index = index < images.count ? index + 1 : 1
                        // selectedNum 값은 images 배열의 element 값
                        selectedNum = images[index - 1]
                    }
                })
            }
            //버튼: 일시정지
            //            HStack{
            //                Button {
            //                    index = index < images.count ? index + 1 : 1
            //                    selectedNum = images[index - 1]
            //                } label: {
            //                    Image(systemName: "chevron.right")
            //                        .foregroundStyle(.black)
            //                }
            //            }
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
