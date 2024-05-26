//
//  GetHeartResponseModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/24.
//

import Foundation
struct GetHeartResponseModel : Codable {
    let header : GetHeartHeader
    let body : GetHeartBody
}
struct GetHeartHeader : Codable {
    let resultCode : Int?
    let message : String?
}
struct GetHeartBody : Codable {
    let data : String?
    let message : String?
}
