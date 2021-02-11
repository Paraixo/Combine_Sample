//
//  CountUpVM.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/11.
//

import Foundation
import Combine

//Input, Output分け

protocol CountUpVMInput {
    var tappedCountupBtn: AnySubscriber<Void, Never> {get}
    var tappedResetCountBtn: AnySubscriber<Void, Never> {get}
}

protocol CountUpVMOutput {
    var tapCount: AnyPublisher<Int, Never> {get}
}


protocol CountUpVMType {
    var input: CountUpVMInput {get}
    var outout: CountUpVMOutput {get}
}


class CountUpVM: CountUpVMInput, CountUpVMOutput {
    
    var cancellables = Set<AnyCancellable>()
    
    //input
    var tappedCountupBtn: AnySubscriber<Void, Never>
    var tappedResetCountBtn: AnySubscriber<Void, Never>
    
    //output
    var tapCount: AnyPublisher<Int, Never>
    
    
    init() {
        
        var count = 0
        
        let _tapCount = PassthroughSubject<Int, Never>()
        tapCount = _tapCount.eraseToAnyPublisher()
        
        tappedCountupBtn = AnySubscriber<Void, Never>(receiveCompletion:  {[] event in
            print(event, "CountUp")
            count += 1
            _tapCount.send(count)
        })
        
        tappedResetCountBtn = AnySubscriber<Void, Never>(receiveCompletion:  { event in
            count = 0
            _tapCount.send(count)
        })
    }
}

extension CountUpVM: CountUpVMType {
    var input: CountUpVMInput {return self}
    var outout: CountUpVMOutput {return self}
}
