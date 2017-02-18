//
//  diceNYC.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import Foundation

class DiceJob {

    let url: String
    let jobTitle: String
    let company: String
    let location: String
    let date: String
    
    
    init(url:String, jobTitle: String, company:String, location:String, date: String) {
        self.url = url
        self.jobTitle = jobTitle
        self.company = company
        self.location = location
        self.date = date
    }
    
    convenience init?(from json: [String: Any]) {
        let url = json["detailUrl"] as? String ?? ""
        let jobTitle = json["jobTitle"] as? String ?? ""
        let company = json["company"] as? String ?? ""
        let location = json["location"] as? String ?? ""
        let date = json["date"] as? String ?? ""
        
        self.init(url:url,jobTitle: jobTitle, company: company, location: location, date:date)
    }
    
    static func getJobs(from dict:[String:Any]) -> [DiceJob] {
        let resultItem = dict["resultItemList"] as! [[String:Any]]
        let jobs = resultItem.flatMap{ DiceJob(from: $0 ) }
        return jobs
        
    }




}
