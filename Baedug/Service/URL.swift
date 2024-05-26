//
//  URL.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/16.
//

import Foundation

let endpointURL = "https://baedug.com"

//MARK: - Directory
//디렉토리 생성
let postDirectoryURL = "/api/directory"
//디렉토리 조회
let getDirectoryURL = "/api/directory"
//디렉토리 내 노트 조회
let getDetailURL = "/api/directory/" //api/directory/{directoryId}/note

//MARK: - Heart
//좋아요 생성
let postHeartURL = "/api/note/" //api/note/{noteId}/heart
//좋아요 조회
let getHeartURL = "/api/heart"

//MARK: - Note
//노트 생성
let postNoteURL = "/api/directory/" //api/directory/{directoryId}/note
//노트 상세 조회
let detailNoteURL = "/api/note/" //api/note/{noteId}
