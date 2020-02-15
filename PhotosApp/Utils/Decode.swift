//
//  File.swift
//  PhotosApp
//
//  Created by Omer Elimelech on 20 Shevat 5780.
//  Copyright © 5780 Omer Elimelech. All rights reserved.
//

import Foundation

func decode<T : Codable>(withObj obje: T.Type, data: Data) throws -> T?{
    
    let decoder = JSONDecoder()
    do {
        let obj = try decoder.decode(obje.self, from: data)
        return obj
    } catch {
        throw error
    }
    
}
