//
//  QiitaListVM.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import Foundation
import SwiftUI
import Combine

class QiitaListViewModel: ObservableObject  {
    
    
    
    
    //OutPut
    @Published var items = [QiitaItem]()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
        QiitaRequest.getQiita().sink { (result) in
            switch result {
            case .finished: break
            case .failure(let error):
                print("GetQiitaError:",error)
            }
        } receiveValue: { [self] qiitaitem in
            self.items = qiitaitem
        }.store(in: &cancellables)
    }
}
