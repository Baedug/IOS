//
//  AddNoteResponseModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/25.
//

import Foundation
struct AddNoteResponseModel : Codable {
    let header : AddNoteHeader?
    let message : AddNoteData?
}
struct AddNoteHeader : Codable {
    let resultCode : Int?
    let message : String?
}
struct AddNoteData : Codable {
    let data : String?
    let message : String?
}
