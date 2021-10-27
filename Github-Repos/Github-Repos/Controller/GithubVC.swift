//
//  ViewController.swift
//  Github-Repos
//
//  Created by Anshul Singh Koshyari on 26/10/21.
//

import UIKit

class GithubVC: UIViewController{
    
    @IBOutlet weak var table: UITableView!
    
    var apiService = ApiService()
    var repos: Repo?
    var ans: [Items]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
    }
    
    func fetchRepos(completion: @escaping () -> ()) {
        apiService.parseJSON { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.ans = listOf.items
                completion()
            case .failure(let error):
                print("Error in processing JSON Data: \(error)")
            }
        }
    }

}

extension GithubVC: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ans?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TableViewCell
        cell.configure(with: (ans?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.table.performBatchUpdates(nil)
        }
    }
}
