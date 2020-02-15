//
//  APIManager.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import Alamofire

typealias completion = (_ result: Result<Any?>) -> Void
typealias parameters = [String : Any]


class APIManager : NSObject {
    
    static let shared = APIManager()
    
    func getByQuery(keyword: String, page: Int, completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .base)
        let params : [String: Any] = [Constants.ParameterKey.key: Constants.APIkey ,Constants.ParameterKey.query: keyword, Constants.ParameterKey.page: page]
        self.request(withUrlString: url, method: .get, params: params,  completion: completion)
        
    }
    
}

//MARK: Base requests
extension APIManager {
    
    func request(withUrlString urlString: String, method: HTTPMethod, params: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping completion){
        guard let url = URL(string: urlString) else {return}
        Alamofire.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any] else {completion(.failure(MyError.parsingError)); return}
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
}
