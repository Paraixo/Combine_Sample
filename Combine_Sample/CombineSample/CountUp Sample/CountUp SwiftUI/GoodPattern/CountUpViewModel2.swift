//
//  CountUpViewModel.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/17.
//

import Foundation
import Combine

final class CountUpViewModel2: ViewModelObject {
    
    final class Input: InputObject {
        let tapCountBtn = PassthroughSubject<Void, Never>()
        let tapResetBtn = PassthroughSubject<Void, Never>()
    }
    
    final class Binding: BindingObject {
        @Published var countText: String = "0"
    }
    
    final class Output: OutputObject {
        
    }
    
    let input: Input
    @BindableObject private(set) var binding: Binding
    let output: Output
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let input = Input()
        let binding = Binding()
        let output = Output()
        
        
        var count = 0
        
        let _ = input.tapCountBtn.sink { _ in
            count += 1
            binding.countText = "\(count)"
        }.store(in: &cancellables)
        
        let _ = input.tapResetBtn.sink { _ in
            count = 0
            binding.countText = "\(count)"
        }.store(in: &cancellables)

        
        self.input = input
        self.binding = binding
        self.output = output
    }
    
}
