//
//  URLManager.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//


struct UrlManager {
    
    static let shared = UrlManager()
    
    var baseUrl = Constants.baseUrl
    
    enum Endpoint {
        typealias RawValue = String
        case base
        
        var rawValue: String {
            switch self {
            case .base:
                return ""
            }
        }
        
        private func fotmattedString(string: String, withParam param: String) -> String{
            return String(format: string, param)
        }
    }
    func url(endpoint: Endpoint) -> String{
        return "\(baseUrl)\(endpoint.rawValue)"
    }
    
    
    
    
    
}
