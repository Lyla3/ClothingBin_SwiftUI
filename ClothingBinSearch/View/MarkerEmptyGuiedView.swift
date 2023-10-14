//
//  MarkerEmptyGuiedView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/10/12.
//

import SwiftUI

struct MarkerEmptyGuiedView: View {
    var body: some View {
        ZStack{
            Text("현재 지도상에 의류수거함이 없습니다.")
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

struct MarkerEmptyGuiedView_Previews: PreviewProvider {
    static var previews: some View {
        MarkerEmptyGuiedView()
    }
}
