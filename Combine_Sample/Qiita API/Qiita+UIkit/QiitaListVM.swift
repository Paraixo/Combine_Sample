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
}


protocol QiitaListVMType {
    var input: QiitaListVMInput {get}
    var outout: QiitaListVMOutput {get}
}


class QiitaListVM: QiitaListVMInput, QiitaListVMOutput {
    
    var cancellables = Set<AnyCancellable>()
    
    //input
    
    //output
    
    
    
    init() {
    }
}

extension QiitaListVM: QiitaListVMType {
    var input: QiitaListVMInput {return self}
    var outout: QiitaListVMOutput {return self}
}
