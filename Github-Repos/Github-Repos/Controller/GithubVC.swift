//
//  ViewController.swift
//  Github-Repos
//
//  Created by Anshul Singh Koshyari on 26/10/21.
//

import UIKit

class GithubVC: UIViewController{
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var sortByStars: UIButton!
    @IBOutlet weak var sortByName: UIButton!
    
    var apiService = ApiService()
    var repos: Repo?
    var ans: [Items]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        loadMenuView()
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func starsPressed(_ sender: UIButton) {
        ans?.sort { (item1: Items, item2: Items) in
            return (item1.stargazers_count ?? 0) > (item2.stargazers_count ?? 0)
        }
        table.reloadData()
    }
    
    @IBAction func namePressed(_ sender: UIButton) {
        ans?.sort { (item1: Items, item2: Items) in
            return (item1.name ?? "") < (item2.name ?? "")
        }
        table.reloadData()
    }
    
    func loadMenuView() {
        menuView.isHidden = true
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowOffset = .zero
        menuView.layer.shadowRadius = 4
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
