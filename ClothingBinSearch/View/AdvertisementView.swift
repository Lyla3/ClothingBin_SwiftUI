//
//  AdvertisementView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2024/01/30.
//

import SwiftUI

struct AdvertisementView: View {
    @State private var isShowingInfo = true
    @State private var lastShownDate = UserDefaults.standard.object(forKey: "lastShownDate") as? Date ?? Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1))!

    @State var isShowingAdvertisementView :Bool = true
    
    var body: some View {
        if isShowingAdvertisementView && Calendar.current.isDateInToday(Calendar.current.startOfDay(for: lastShownDate)) {
            VStack {
                HStack{
                    Spacer()
                    Button {
                        isShowingAdvertisementView = false
                    } label:{
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding()
                    }
                }
                Text("이곳에 정보를 보여줍니다.")
                    .foregroundColor(.black)
                    .padding()
                Spacer()

                HStack{
                    Button("오늘 하루동안 보지 않기") {
                        lastShownDate = Date()
                        isShowingAdvertisementView = false
                        
                        UserDefaults.standard.set(lastShownDate, forKey: "lastShownDate")
                    }
                    
                    Button("닫기") {
                        isShowingAdvertisementView = false
                    }
                    .padding()
                }
                .padding()
            }
            .frame(width: CGFloat.screenWidth * 0.8, height: CGFloat.screenHeight * 0.6)
            .background(.white)
            .onAppear {
                let calendar = Calendar.current
                let today = calendar.startOfDay(for: Date())
                let lastShownDay = calendar.startOfDay(for: lastShownDate)
                
                if calendar.isDateInToday(lastShownDay) {
                    isShowingAdvertisementView = false
                } else {
                    isShowingAdvertisementView = true
                }
            }
        }
    }
}

struct AdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisementView()
    }
}
