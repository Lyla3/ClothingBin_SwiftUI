//
//  GuideView2.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/11/25.
//

import SwiftUI

struct GuideView2: View {
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var index = 1
    
    let guideDataSet: imageDataSet = imageDataSet()
    @State private var selectedImageName: String = ""
    @State var isShowingGuide: Bool = true
    @State var isStopedtimer: Bool = false
    @State var selectedNumber: Int = 0
    var body: some View {
        VStack(){
            HStack{
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
                .border(.black)
               
            }
            HStack {
                Button {
                    selectedNumber = 0
                } label: {
                    Image(systemName: "map")
                    Text("지도")
                }
                .padding(.bottom, 10)
                .padding(.trailing, 10)
                .modifier(YellowBottomBorder(showBorder: selectedNumber == 0))
                
                Button {
                    selectedNumber = 1
                } label: {
                    Image(systemName: "text.justify")
                    Text("피드")
                }
                .foregroundColor(selectedNumber == 1 ? .mainColor : .gray)
                .padding(.bottom, 10)
                .padding(.trailing, 10)
                .modifier(YellowBottomBorder(showBorder: selectedNumber == 1))
            }
            Text("??")
            VStack{
                Image(guideDataSet.images[index])
                    .resizable()
                    .scaledToFit()
                    .frame(width: CGFloat.screenWidth*0.7)
                    .clipped()
                Text("\(guideDataSet.guiedText[index])")
            }
            .onReceive(timer, perform: { _ in
                withAnimation {
                    // index값을 증가, 아니면 1
                    // (selectedNum의 값을 변경해주기 위함)
                    
                    if isStopedtimer {
                        
                    } else {
                        index = index < guideDataSet.images.count - 1 ? index + 1 : 0
                        // selectedNum 값은 images 배열의 element 값
                        
                        
                    }
                }
            })
            .frame(height: CGFloat.screenHeight*0.7)
            .clipped()
        }
    }
}

#Preview {
    GuideView2()
}
