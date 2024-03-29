//
//  HIDEAPIKEY++Bundle.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/29.
//

import Foundation
extension Bundle {
    var OpenAiKey : String {
        guard let file = self.path(forResource: "ApiKeyList", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["OpenAiKey"] as? String else { fatalError("ApiKeyList.plist에 API_KEY를 설정해 주세요.")}
        return key
    }
}
