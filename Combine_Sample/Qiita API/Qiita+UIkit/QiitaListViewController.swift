//
//  QiitaListViewController.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import UIKit

class QiitaListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = QiitaListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}
//
//extension QiitaListViewController: UITableViewDelegate {
//
//}
//
//extension QiitaListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
