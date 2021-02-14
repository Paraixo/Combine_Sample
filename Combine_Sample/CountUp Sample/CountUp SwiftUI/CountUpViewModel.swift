//
//  CountUpViewModel2.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/11.
//

import Foundation
import Combine

//classでoutput,Input分け

//参考
//https://qiita.com/yimajo/items/b7c1a309f285e07a3f49

class CountUpViewModel: ObservableObject {
    
    
    class Input {
        let tapCountBtn = PassthroughSubject<Void, Never>()
        let tapResetBtn = PassthroughSubject<Void, Never>()
    }
    
    class Output {
        //ViewのTextに反映されない。
        @Published var countText: String = "0"
    }
    
    var input: Input
    var output: Output
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var countText: String = "0"
    
    init() {
        self.input = Input()
        self.output = Output()
        
        var count = 0
        let _countSubject = PassthroughSubject<Int, Never>()
        
        input.tapCountBtn.sink { (_) in
            print("countupBtn")
            count += 1
            _countSubject.send(count)
        }.store(in: &cancellables)
        
        input.tapResetBtn.sink { (_) in
            print("resetBtn")
            count = 0
            _countSubject.send(count)
        }.store(in: &cancellables)
        
        _countSubject.sink {[unowned self] value in
            count = value
            self.countText = "\(count)"
            //print("sink",output.countText)
        }.store(in: &cancellables)
    }
    
}
