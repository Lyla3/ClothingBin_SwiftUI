//
//  Region.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/27.
//

import Foundation

enum Region: String, CaseIterable {
    case Gangnam = "서울시 강남구"
    case Gangdong = "서울시 강동구"
    case Gwanak = "서울시 관악구"
    case Gwangjin = "서울시 광진구"
    case Geumcheon = "서울시 금천구"
    case Nowon = "서울시 노원구"
    case Dongdaemun = "서울시 동대문구"
    case Dongjak = "서울시 동작구"
    case Guro = "서울시 구로구"
    case Mapo = "서울시 마포구"
    case Seocho = "서울시 서초구"
    case Songpa = "서울시 송파구"
    case Yangcheon = "서울시 양천구"
    case YeoungDeugpo = "서울시 영등포구"
    case Eunpyeong = "서울시 은평구"
    case Seodaemun = "서울시 서대문구"
    case Gongro = "서울시 종로구"
    
    
    func getFileName() -> String {
        switch self {
        case .Gangnam:
            return "Seoul_Gangnam"
        case .Gangdong:
            return "Seoul_Gangdong"
        case .Geumcheon:
            return "Seoul_Geumcheon"
        case .Gwangjin:
            return "Seoul_Gwangjin"
        case .Nowon:
            return "Seoul_Nowon"
        case .Dongdaemun:
            return "Seoul_Dongdaemun"
        case .Dongjak:
            return "Seoul_Dongjak"
        case .Guro:
            return "Seoul_guro"
        case .Mapo:
            return "Seoul_Mapo"
        case .Seocho:
            return "Seoul_Seocho"
        case .Songpa:
            return "Seoul_Songpa"
        case .Yangcheon:
            return "Seoul_Yangcheon"
        case .YeoungDeugpo:
            return "Seoul_Yeoungdeungpo"
        case .Eunpyeong:
            return "Seoul_Eunpyeong"
        case .Gwanak:
            return "Seoul_gwanak"
        case .Seodaemun:
            return "Seoul_Seodaemun"
        case .Gongro:
            return "Seoul_Gongro"
        }
    }
}
