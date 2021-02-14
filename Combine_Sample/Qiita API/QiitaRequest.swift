//
//  QiitaRequest.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import Foundation
import Alamofire
import Combine
import SwiftyJSON

struct QiitaRequest {
    
    static func getQiita(param:[String: Any]?) -> AnyPublisher<[QiitaItem], Never> {
        let publisher = Future<[QiitaItem], Never> { promise in
            let urlString = "https://qiita.com/api/v2/items"
            
            
            
            AF.request(urlString, method: .get, parameters: param).responseJSON { (response) in
                guard let data = response.data else {return}
                
                let json = try! JSON(data: data)
                print(json)
                do {
                    let qiitaItem = try JSONDecoder().decode([QiitaItem].self, from: data)
                    promise(.success(qiitaItem))
                } catch(let error) {
                    print("CatchError:\(error)")
                    //promise(.failure(Never()))
                }
            }
        }.eraseToAnyPublisher()
        return publisher
    }
}
