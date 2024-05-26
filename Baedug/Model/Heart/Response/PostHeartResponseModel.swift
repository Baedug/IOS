//
//  PostHeartResponseModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/24.
//

import Foundation
struct PostHeartResponseModel : Codable {
    let header : PostHeartHeader
    let body : PostHeartBody
}
struct PostHeartHeader : Codable {
    let resultCode : Int?
    let message : String?
}
struct PostHeartBody : Codable {
    let data : String?
    let message : String?
}
