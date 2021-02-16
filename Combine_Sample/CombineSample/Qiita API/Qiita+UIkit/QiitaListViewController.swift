//
//  QiitaListViewController.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/14.
//

import UIKit
import Combine

class QiitaListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = QiitaListVM()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        viewModel.output.reload.sink { (_) in
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

}

extension QiitaListViewController: UITableViewDelegate {

}

extension QiitaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = viewModel.output.items[indexPath.row].title
        return cell
    }
}
