//
//  GetDetailResponseModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/26.
//

import Foundation
struct GetDetailResponseModel : Codable {
    let header : GetDetailHeader?
    let body : GetDetailBody?
}
struct GetDetailHeader : Codable {
    let resultCode : Int?
    let message : String?
}
struct GetDetailBody : Codable {
    let data : [GetDetailData]?
    let message : String?
}
struct GetDetailData : Codable {
    let title : String?
    let content : String?
}
