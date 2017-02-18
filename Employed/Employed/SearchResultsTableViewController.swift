//
//  SearchResultsTableViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

//     var jobs = [NYCJobs]()
    var jobs = [DiceJob]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        let barButton = UIBarButtonItem(customView: filterButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        
        self.view.backgroundColor = UIColor.green
        getData()
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "nycCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    

//    func getData() {
//        APIRequestManager.manager.getPOD(endPoint: "https://data.cityofnewyork.us/resource/swhp-yxa4.json") { (data) in
//            
//            if let validData = data {
//                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []),
//                    let validJob = jsonData as? [[String:Any]] {
//                    
//                    self.jobs = NYCJobs.getJobs(from: validJob)
//                    
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//                
//            }
//        }
//    }
    
        func getData() {
            APIRequestManager.manager.getPOD(endPoint: "http://service.dice.com/api/rest/jobsearch/v1/simple.json?&city=New+York,+NY") { (data) in
    
                if let validData = data {
                    if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []),
                        let validJob = jsonData as? [String:Any] {
    
                        self.jobs = DiceJob.getJobs(from: validJob)
    
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
    
                }
            }
        }
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(filterButton)
    }
    
    func configureConstraints() {
    
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
        cell.textLabel?.text = selectedCell.jobTitle
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func filterButtonPressed(sender: UIButton) {
    
    }
    
    
    internal lazy var filterButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        button.setTitle("Filter", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        return button
    }()

    
}
