//
//  TextFieldSampleViewModel.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/12.
//

import Foundation
import Combine

// InputとOutputをなるべく分けたいので型にした
class TFSViewModel: ObservableObject {
    class Input {
        @Published var password = ""
        @Published var repeatedPassword = ""
    }

    class Output {
        @Published var validatedPassword = false
    }

    // input
    var input: Input
    // output
    var output: Output

    private var cancellableSet: Set<AnyCancellable> = []

    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output

        Publishers.CombineLatest(self.input.$password, self.input.$repeatedPassword)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
            .assign(to: \.validatedPassword, on: self.output)
            .store(in: &cancellableSet)
    }
}
