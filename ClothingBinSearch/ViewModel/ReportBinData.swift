//
//  SelectedBinData.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2024/01/06.
//

import Foundation

class ReportBinData: ObservableObject {
    @Published var binData: String = ""
    
    //ReportView/ReportCheckView 켜기 담당
    @Published var isShowingReportView: Bool = false
    @Published var isShowingReportCheckView: Bool = false
}
