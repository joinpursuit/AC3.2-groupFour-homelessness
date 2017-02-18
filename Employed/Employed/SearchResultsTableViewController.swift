//
//  SearchResultsTableViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

     var jobs = [NYCJobs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        getData()
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "nycCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    

    func getData() {
        APIRequestManager.manager.getPOD(endPoint: "https://data.cityofnewyork.us/resource/swhp-yxa4.json") { (data) in
            
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []),
                    let validJob = jsonData as? [[String:Any]] {
                    
                    self.jobs = NYCJobs.getJobs(from: validJob)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobs.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nycCell", for: indexPath) as! SearchTableViewCell
        
        let selectedCell = jobs[indexPath.row]
        cell.textLabel?.text = selectedCell.buisnessTitle
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        let searchDetailVc = SearchDetailViewController()
        searchDetailVc.jobPost = jobs[selectedRow]
        
        navigationController?.pushViewController(searchDetailVc, animated: true)
    }

}
