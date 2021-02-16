//
//  ViewController.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/11.
//

import UIKit
import SwiftUI
import Combine
import CombineCocoa

class ViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var uikitPushBtn: UIButton!
    @IBOutlet weak var swiftUIPushBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        uikitPushBtn
            .tapPublisher
            .sink { (_) in
//                let storyBoard = UIStoryboard(name: "CountUpViewController", bundle: nil)
//                let vc = storyBoard.instantiateViewController(identifier: "CountUpViewController")
//                self.navigationController?.pushViewController(vc, animated: true)
                self.qiitaListVCPush()
            }.store(in: &cancellables)
        
        
        swiftUIPushBtn
            .tapPublisher
            .sink { (_) in
                let view = UIHostingController(rootView: QiitaListView())
                self.navigationController?.pushViewController(view, animated: true)
            }.store(in: &cancellables)
    }
    
    func qiitaListVCPush() {
        let storyBoard = UIStoryboard(name: "QiitaListViewController", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "QiitaListViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

