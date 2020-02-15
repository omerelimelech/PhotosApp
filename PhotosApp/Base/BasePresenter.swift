//
//  BasePresenter.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation
import Alamofire

class BasePresenter : NSObject {
    
    var error: Error?
    
    func handleResult<T: Codable>(result: Result<Any?>, type: T.Type, forKey key: String, completion: @escaping (_ result: T?) -> Void){
        switch result{
        case .success(let value):
            guard let value = value as? [String: Any],
                let subValue = value[key] as? [[String: Any]] else {
                    handleError(error: MyError.parsingError)
                    return
            }
            let data = try? JSONSerialization.data(withJSONObject: subValue, options: .prettyPrinted)
            guard let obj = try? decode(withObj: type.self, data: data!) else {
                handleError(error: MyError.decodeError)
                return
            }
            completion(obj)
        case .failure(let error):
            handleError(error: error)
        }
    }
    
    func handleResultWithoutResponse(result: Result<Any?>) -> Error?{
        return result.error
    }
    
    
    func handleError(error: Error) -> Void {
        self.error = error
    }
}
