//
//  Combine.swift
//  SwiftUI_Sample
//
//  Created by 服部翼 on 2021/02/04.
//

import Foundation
import Combine


/*
 Publishers -> イベントの発行者です
 Subscribers -> イベントの購読者です
 Operators -> 流れてくる値を加工することができます
 */

//protocol ViewModelInput {
//    var text: AnyPublisher<String, Never>{get}
//
//}
//
//protocol ViewModelOutput {
//
//}


//もう何も考えずにやれるようにやっていく例。
//@Publishedが増えてinputかoutputか分かりづらい。
class ViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    //input
    let addBtnTaped = PassthroughSubject<Void, Never>()
    @Published var bindText: String = ""
    
    //output
    @Published var items: [String] = []
    
    init() {

        addBtnTaped.sink {[weak self] _ in
            guard let self = self,
                  !self.bindText.isEmpty else {return}
            self.items.insert(self.bindText, at: 0)
        }.store(in: &cancellables)
    }
}


