//
//  ZoomLevelGuideView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/30.
//

import SwiftUI

struct ZoomLevelGuideView: View {
    var body: some View {
        ZStack{
            Text("지도를 확대해주세요.")
                .foregroundColor(.white)
                .font(.body)
                .frame(width:300)
                .padding(.horizontal, 4)
                .padding(.vertical, 18)
                .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.white.opacity(0.5))
                    .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.black.opacity(0.7))
                )
                )
        }
    }
}

struct ZoomLevelGuideView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomLevelGuideView()
    }
}
