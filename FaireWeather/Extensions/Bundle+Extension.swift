//
//  Bundle+Extension.swift
//  FaireWeather
//
//  Created by Yuri Chaves on 18/09/22.
//

import Foundation
extension Bundle {
    var apiBaseUrl: String {
        guard
            let stringUrl = object(forInfoDictionaryKey: "API_URL") as? String
        else {
            fatalError("INVALID BASE API URL")
        }
        return stringUrl
    }

    var apiImageUrl: String {
        guard
            let stringUrl = object(forInfoDictionaryKey: "API_IMAGE_URL") as? String
        else {
            fatalError("INVALID API IMAGE URL")
        }
        return stringUrl
    }
}
