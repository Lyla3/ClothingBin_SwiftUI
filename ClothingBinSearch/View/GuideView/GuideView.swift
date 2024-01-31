//
//  2.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2024/01/27.
//

import SwiftUI

struct GuideView: View {
    @Binding var isShowingGuide: Bool
    var body: some View {
        ZStack{
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                isShowingGuide = false
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .font(.title2)
                    .frame(width: 15)
                    .padding(13)
                    .background(Color(.lightGray))
                    .cornerRadius(30)
                    .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .frame(maxHeight: 50, alignment: .top)
            .position(x: CGFloat.screenWidth - 35, y:32)
            HStack{
                Button {
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
                .disabled(true)
                .position(x: 38, y:UIScreen.main.bounds.height - 200)

                Image("currentLocationButtonEXP")
                    .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: .infinity)
                        .frame(height: 44)
                        .position(x: 20, y: UIScreen.main.bounds.height - 200)
            }//:HStack
            
            HStack{
                Button {
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
                .disabled(true)
                .position(x:UIScreen.main.bounds.width / 2, y: 32)
                Image("currentMapGuideEXP")
                    .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: .infinity)
                        .frame(height: 44)
                        .position(x: 0, y: 85)
                
            }
            Button {
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
            .disabled(true)
            .position(x:UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height - 120)
        } //:ZStack
        .onTapGesture {
                    isShowingGuide = false
                }
        .transition(.opacity)
    }
}

#Preview {
    GuideView(isShowingGuide: .constant(true))
}
