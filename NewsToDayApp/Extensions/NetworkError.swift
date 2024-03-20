//
//  NetworkError.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 19.03.2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case wrongUrl
    case notFoundData
    case wrongCode
    case invalidImageData
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .wrongUrl:
            return NSLocalizedString("InvalidURL", comment: "")
        case .notFoundData:
            return NSLocalizedString("EmptyResponse", comment: "")
        case .wrongCode:
            return NSLocalizedString("ErrorCodeResponse", comment: "")
        case .invalidImageData:
            return NSLocalizedString("InvalidImageData", comment: "")
        }
    }
}
