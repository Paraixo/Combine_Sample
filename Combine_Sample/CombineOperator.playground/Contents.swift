import UIKit
import Combine

/*
 Publishers -> イベントの発行者です
 Subscribers -> イベントの購読者です
 Operators -> 流れてくる値を加工することができます
 */

var cancellable = Set<AnyCancellable>()

class Model {
    @Published var text: String = "A"
    @Published var intValue: Int = 0
    
    let subjectX = PassthroughSubject<String, Never>()
    let subjectY = PassthroughSubject<String, Never>()
}

class ViewModel {
    
    var text: String = "" {
        didSet {
            print("didSet text:", text)
        }
    }
    
    var intValue: String = "" {
        didSet {
            print("didSet intValue:", intValue)
        }
    }
    
    var subject: String = "" {
        didSet {
            print("didSet subject:", subject)
        }
    }
}

let model = Model()

class Receiver {
    var cancellable = Set<AnyCancellable>()
    let viewModel = ViewModel()
    
    let formatter = NumberFormatter()
    
    init() {
        formatter.numberStyle = .spellOut
        
        //Binding
        //Modelのtextの値が変わるとViewModelのtextに自動的に反映される
        model.$text
            .assign(to: \.text, on: viewModel)
            .store(in: &cancellable)
        
        //Map,Filter
        model.$intValue
            .filter({ (value) in
                value % 2 == 0
            })
            //            .map { value in
            //                (self.formatter.string(from: NSNumber(integerLiteral: value)) ?? "")
            //            }
            .compactMap({ (value) in
                //値がnilの場合はpublishしない
                self.formatter.string(from: NSNumber(integerLiteral: value))
            })
            .assign(to: \.intValue, on: viewModel)
            .store(in: &cancellable)
        
        //Publisherのうちどちらかがpublishした場合に両方の最新の値をタプルで組にしてpublishする。
        //ただし、片方がまだひとつもpublishしていない場合はpublishしない
        model.subjectX
            .combineLatest(model.subjectY)
            .map { x, y in
                "X:" + x + "Y:" + y
            }
            .assign(to: \.subject, on: viewModel)
            .store(in: &cancellable)
    }
}

//let reveiver = Receiver()
//model.text = "2"
//model.intValue = 10
//model.intValue = 39


//model.subjectX.send("1")
//model.subjectX.send("2")
//model.subjectY.send("3")
//model.subjectY.send("4")
//model.subjectX.send("5")


//MARK: Prepend
class Prepend {
    //.publisher後ろにつけてpublisherにする？
    let publisher = ["c", "d"].publisher
    
    let pubA = [1,2].publisher
    let pubB = [3,4].publisher
    
    let pubC = PassthroughSubject<Int, Never>()
    
    init() {
        //prepend Publisherの後に値を出力する。
        
        publisher
            .prepend("a", "b")
            .sink { (value) in
                print(value)
            }.store(in: &cancellable)
        
        
        //前のPublisherが終了しないと、次のPublisherの値が出力されない。
        pubA
            .prepend(pubB)
            .sink { (value) in
                print(value)
            }.store(in: &cancellable)
        
        //下の場合pubCが終了しないとpubAは流れない
        pubA
            .prepend(pubC)
            .sink { (value) in
                print(value)
            }.store(in: &cancellable)
        
        pubC.send(5)
        pubC.send(completion: .finished)
    }
}

//let prepend = Prepend()

//MARK: Append
class Append {
    //Append 対象のPublisherの後に値を出力する。
    //基本的にはPrependと同様
    
    let publisherA = ["c", "d"].publisher
    let publisherB = ["a", "b"].publisher
    
    init() {
        publisherA.append(publisherB)
            .sink { (value) in
                print("Append:",value)
            }.store(in: &cancellable)
    }
}

//let append = Append()


//MARK: Merge
class Merge {
    
    //Publisherの後に出力されるPublisherを繋げます。
    //最大8つ繋げることができます。
    let publisherA = PassthroughSubject<String, Never>()
    let publisherB = PassthroughSubject<String, Never>()
    
    init() {
        publisherA.merge(with: publisherB)
            .sink { (completion) in
                print("Finish")
            } receiveValue: { value in
                print("Merge:",value)
            }.store(in: &cancellable)
        
        publisherA.send("A:a")
        publisherA.send("A:b")
        publisherB.send("B:c")
        publisherA.send("A:d")
        publisherB.send("B:e")
        
        //competionは下2つを書かないと流れない。
        publisherA.send(completion: .finished)
        publisherB.send(completion: .finished)
        
    }
}

//let merge = Merge()


class SwitchToLatest {
    /*
     複数のPublisherを一つのPublisherとして出力するように結合する。
     この際に新しいPublisherを出力すると前のPublisherのSubscriptionはキャンセルされる。
     */
    
    let publisherA = PassthroughSubject<String, Never>()
    let publisherB = PassthroughSubject<String, Never>()
    let publisherC = PassthroughSubject<String, Never>()
    
    let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()
    
    init() {
        publishers
            .switchToLatest()
            .sink { (completion) in
                print("Finish")
            } receiveValue: { (value) in
                print("STL:",value)
            }.store(in: &cancellable)
        
        publishers.send(publisherA)
        publisherA.send("A:a")
        publisherA.send("A:b")
        
        // publisherBへ切り替え
        publishers.send(publisherB)
        publisherA.send("A:c") // 出力されない
        publisherB.send("B:d")
        publisherB.send("B:e")
        
        // publisherCへ切り替え
        publishers.send(publisherC)
        publisherB.send("B:f") // 出力されない
        publisherC.send("C:g")
        publisherC.send("C:h")
        publisherC.send("C:i")
        
        //completionは最後のpublisherとpublishersをfinishさせないと流れない。
//        publisherC.send(completion: .finished)
//        publishers.send(completion: .finished)
    }
}

let switchToLatest = SwitchToLatest()
