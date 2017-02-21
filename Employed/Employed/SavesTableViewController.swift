//
//  SavesTableViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import FirebaseDatabase
import FirebaseAuth

class SavesTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   
     var databaseReference = FIRDatabase.database().reference()
    var jobs = [NYCJobs]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Favorites"
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "savedCell")
     
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 150
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FIRAuth.auth()?.currentUser != nil{
            getData()
            
        }
    }
    
    
    func getData() {
        databaseReference.child("SavedJobs").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapShot) in
            var newJobAdded: [NYCJobs] = []
            for child in snapShot.children {
                if let snap = child as? FIRDataSnapshot,
                let valueDict = snap.value as? [String:Any] {
                    let job = NYCJobs(buisnessTitle: valueDict["buisnessTitle"] as! String? ?? " ",
                                      civilTitle: valueDict["civilTitle"] as! String? ?? " ",
                                      jobDescription: valueDict["jobDescription"] as! String? ?? " ",
                                      postingDate: valueDict["postingDate"] as! String? ?? " ",
                                      agency: valueDict["agency"] as! String? ?? " ",
                                      workLocation: valueDict["workLocation"] as! String? ?? " ",
                                      minReqs: valueDict["minReqs"] as! String? ?? " ",
                                      minSalary: valueDict["minSalary"] as! String? ?? " ")
                    newJobAdded.append(job)
                }
            }
            self.jobs = newJobAdded
            
            self.tableView.reloadData()
        })
    }
    
    //MARK: -DZNEmptyDataSet Delegates & DataSource
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No saved Jobs"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Save desired Jobs here"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "folder")
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return jobs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SearchTableViewCell

       let selectedCell = self.jobs[indexPath.row]
        
        cell.jobLabel.text = selectedCell.buisnessTitle
        cell.agencyLabel.text = selectedCell.agency
        cell.subLabel.text = "\(selectedCell.workLocation) • Posted \(selectedCell.postingDate)"
        cell.subLabel.addImage(imageName: "marker")
        self.tableView.reloadEmptyDataSet()

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        let searchDetailVc = SearchDetailViewController()
        searchDetailVc.jobPost = jobs[selectedRow]
        
        navigationController?.pushViewController(searchDetailVc, animated: true)
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

}
