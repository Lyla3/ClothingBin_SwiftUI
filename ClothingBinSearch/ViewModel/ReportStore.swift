//
//  ReportStore.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2024/01/07.
//

import Foundation
import FirebaseFirestore

final class ReportBinStore: ObservableObject {
    @Published var binAddress: String = ""
    @Published var isShowingReportView: Bool = false
    @Published var isShowingReportCheckView: Bool = false
    
    //MARK: - 업로드
    func uploadBin(reason:String){
        
        let db = Firestore.firestore()

        var ref: DocumentReference? = nil
        ref = db.collection("reportBin").addDocument(data: [
            "address": binAddress,
            "reportReason": reason,
            "time": Timestamp(date: Date())
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
