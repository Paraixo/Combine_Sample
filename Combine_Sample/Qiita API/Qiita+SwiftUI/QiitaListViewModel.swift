//
//  QiitaListVM.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import Foundation
import SwiftUI
import Combine
import CombineExt

class QiitaListViewModel: ObservableObject  {
    
    //Input
    var tappedArtcleBtn = PassthroughSubject<Void, Never>()
    
    //OutPut
    @Published var items = [QiitaItem]()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
        tappedArtcleBtn
            .withLatestFrom(QiitaRequest.getQiita(param: ["query": "swift",
                                                          "per_page": 20]))
            .sink { (items) in
                self.items = items
        }.store(in: &cancellables)
        
        
        QiitaRequest.getQiita(param: nil).sink { (result) in
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
