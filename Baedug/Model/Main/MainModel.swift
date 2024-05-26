//
//  MainModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/03.
//

import Foundation
struct MainResponseModel : Codable {
    let header : MainHeader?
    let body : MainBody?
}
struct MainHeader : Codable {
    let resultCode : Int?
    let message : String?
}
struct MainBody : Codable {
    let data : [MainData]?
    let message : String?
}
struct MainData : Codable {
    let title : String?
    let content : String?
}

