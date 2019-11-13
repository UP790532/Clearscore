//
//  JSONParsing.swift
//  ClearScoreTechnicalTask
//
//  Created by Jack Sherwood on 07/11/2019.
//  Copyright © 2019 Jack Sherwood. All rights reserved.
//

import Foundation

struct Account: Decodable {
    let creditReportInfo: CreditScore
}


struct CreditScore: Decodable {
    let score: Int
    let minScoreValue: Int
    let maxScoreValue: Int
}


let url = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")

class JSONParsing {
    
    func parseJSON(completion: @escaping ((_ data: Account,_ score: Int) -> Void)) {
        
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            guard let data = data else{
                print("No data... Something went wrong")
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(Account.self, from: data)
                let score = jsonData.creditReportInfo.score
                completion(jsonData, score)
            }
            catch let error {
                print(error)
            }
            
        }.resume()
    }
}
