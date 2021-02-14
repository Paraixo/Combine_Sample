//
//  QiitaListViewModel.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import Foundation
import Combine

protocol QiitaListVMInput {
}

protocol QiitaListVMOutput {
    var items: [QiitaItem] {get}
    var reload: AnyPublisher<Void, Never> {get}
}


protocol QiitaListVMType {
    var input: QiitaListVMInput {get}
    var output: QiitaListVMOutput {get}
}


class QiitaListVM: QiitaListVMInput, QiitaListVMOutput {
    
    var cancellables = Set<AnyCancellable>()
    
    //input
    
    //output
    var items: [QiitaItem]
    var reload: AnyPublisher<Void, Never>
    
    
    init() {
        items = [QiitaItem]()
        
        let _reload = PassthroughSubject<Void, Never>()
        reload = _reload.eraseToAnyPublisher()
        
        QiitaRequest.getQiita(param: nil).sink {[unowned self] (items) in
            self.items = items
            _reload.send(Void())
        }.store(in: &cancellables)
    }
}

extension QiitaListVM: QiitaListVMType {
    var input: QiitaListVMInput {return self}
    var output: QiitaListVMOutput {return self}
}
