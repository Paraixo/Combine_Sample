//
//  QiitaRequest.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import Foundation
import Alamofire
import Combine

struct QiitaRequest {
    
    static func getQiita() -> AnyPublisher<[QiitaItem], Error> {
        let publisher = Future<[QiitaItem], Error> { promise in
            let urlString = "https://qiita.com/api/v2/items"
            
            AF.request(urlString).responseJSON { (response) in
                guard let data = response.data else {return}
                
                do {
                    let qiitaItem = try JSONDecoder().decode(QiitaItem.self, from: data)
                    promise(.success([qiitaItem]))
                } catch(let error) {
                    print("Error:\(error)")
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
        return publisher
    }
}
