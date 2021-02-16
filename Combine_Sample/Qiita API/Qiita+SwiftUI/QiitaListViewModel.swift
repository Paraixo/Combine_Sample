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

class QiitaListViewModel: ViewModelObject {
    
    
    final class Input: InputObject {
        var tappedArtcleBtn = PassthroughSubject<Void, Never>()
    }
    
    final class Binding: BindingObject {
        @Published var items = [QiitaItem]()
    }
    
    final class Output: OutputObject {
        
    }
    
    let input: Input
    @BindableObject private(set) var binding: Binding
    let output: Output
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        let input = Input()
        let binding = Binding()
        let output = Output()
        
        let _ = input.tappedArtcleBtn
            .withLatestFrom(QiitaRequest.getQiita(param: ["query": "swift",
                                                          "per_page": 20]))
            .sink { (items) in
                binding.items = items
            }.store(in: &cancellables)
        
        
        QiitaRequest.getQiita(param: nil).sink { (result) in
            switch result {
            case .finished: break
            case .failure(let error):
                print("GetQiitaError:",error)
            }
        } receiveValue: { qiitaitem in
            binding.items = qiitaitem
        }.store(in: &cancellables)
        
        self.input = input
        self.binding = binding
        self.output = output
    }
}
