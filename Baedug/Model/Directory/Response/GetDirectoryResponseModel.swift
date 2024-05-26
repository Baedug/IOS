//
//  GetDirectoryResponseModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/24.
//

import Foundation
struct GetDirectoryResponseModel : Codable {
    let header : GetDirectoryHeader?
    let body : GetDirectoryBody?
}
struct GetDirectoryHeader : Codable {
    let resultCode : Int?
    let message : String?
}
struct GetDirectoryBody : Codable {
    let data : [GetDirectoryData]?
    let message : String?
}
struct GetDirectoryData : Codable {
    let id : Int?
    let name : String?
    let createdAt : String?
    let updatedAt : String?
}
