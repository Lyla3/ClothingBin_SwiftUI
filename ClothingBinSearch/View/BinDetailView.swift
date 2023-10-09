//
//  BinDetailView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/09.
//

import SwiftUI

struct BinDetailView: View {
    @State var screenWidth: CGFloat
    @Binding var isShowingBinDetailView: Bool
    @Binding var currentMarkerAddress: String
    
    var body: some View {
        VStack {
            
            HStack {
                Text("의류수거함 정보")
                    .bold()
                Spacer()
                Button {
                    //
                    isShowingBinDetailView = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical ,3)
            .padding(5)
            
            HStack{
                Text("주소")
                    .padding(.horizontal, 4)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.lightGrayColor)
                    )
                Text("\(currentMarkerAddress)")
                Button {
                    //
                } label: {
                    Image(systemName: "doc.on.doc")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 13)
                        

                        .foregroundColor(.middleGrayColor)
                }
                                Spacer()


            }
            .padding(.horizontal, 4)
        }
        .frame(width: screenWidth)
        .background(.white)
    }
}

struct BinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BinDetailView(screenWidth: CGFloat(300), isShowingBinDetailView: .constant(true), currentMarkerAddress: .constant("주소예시"))
    }
}
