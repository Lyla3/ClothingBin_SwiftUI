//
//  ZStackView.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/27.
//

import SwiftUI

struct ZStackView: View {
    var body: some View {
        ZStack(alignment: .bottom){
            Rectangle()
                .fill(.cyan)
                .frame(width: 100, height: 100)
//                .offset(x: 10, y: 100)
                //offset을 써도 원래 위치는 안변한다.
                .border(.black)
            Rectangle()
                .fill(.yellow)
                .frame(width: 50, height: 50)
//                .offset(x: 10, y: 10)
                //offset을 써도 원래 위치는 안변한다.
                .border(.black)
        }
    }
}

struct ZStackView_Previews: PreviewProvider {
    static var previews: some View {
        ZStackView()
    }
}
