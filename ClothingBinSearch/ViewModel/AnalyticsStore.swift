//
//  AnalyticsStore.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/11/06.
//

import Foundation
import FirebaseAnalytics

class AnalyticsStore {
    var uniqueUserID: String
    
    //uniqueUserID 존재 여부에 따라 설정
    init() {
        if let savedUserID = UserDefaults.standard.string(forKey: "uniqueUserID") {
            self.uniqueUserID = savedUserID
        } else {
            self.uniqueUserID = UUID().uuidString
            UserDefaults.standard.set(self.uniqueUserID, forKey: "uniqueUserID")
        }
    }
    
    func logEvent(itemName:String, contentType:String ) {
        print("uniqueUserID:\(uniqueUserID)")
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(uniqueUserID)",
            AnalyticsParameterItemName: itemName,
            AnalyticsParameterContentType: contentType
        ])
    }
}
