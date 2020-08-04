//
//  GetRate.swift
//  iOS-xToUSDApp
//
//  Created by Dmitry Aksyonov on 03.08.2020.
//  Copyright © 2020 Dmitry Aksyonov. All rights reserved.
//

import Foundation

class GetRate {
    
    static let shared = GetRate()
    
    func getRate(tag: String, completion: @escaping ((Rate?, Bool)) -> Void) {
        let url = URL(
        string: "https://api.latoken.com/api/v2/rate/\(tag)/USD"
        )!
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Rate.self, from: data)
                    completion((json, true))
                } catch {
                    print(error)
                    completion((nil, false))
                }
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
    func getCurrencies(completion: @escaping (([Currency]?, Bool)) -> Void) {
        let url = URL(
        string: "https://api.latoken.com/api/v2/currency"
        )!
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Array<Currency>.self, from: data)
                    completion((json, true))
                } catch {
                    print(error)
                    completion((nil, false))
                }
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
}
