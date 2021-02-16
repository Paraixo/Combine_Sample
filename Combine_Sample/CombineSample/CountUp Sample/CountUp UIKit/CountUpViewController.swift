//
//  CountUpViewController.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/11.
//

import UIKit
import Combine
import CombineCocoa

class CountUpViewController: UIViewController {

    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var countUpBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vm = CountUpVM()
        
        countUpBtn
            .tapPublisher
            .sink { (_) in
                vm.input.tappedCountupBtn.receive(completion: .finished)
            }.store(in: &cancellables)
        
        resetBtn
            .tapPublisher
            .sink { (_) in
                vm.input.tappedResetCountBtn.receive(completion: .finished)
            }.store(in: &cancellables)
        
        
        vm.outout.tapCount
            .sink { (value) in
                self.countLabel.text = "\(value)"
            }.store(in: &cancellables)
    }
}
