//
//  NYCJobs.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import Foundation

class NYCJobs {

    let buisnessTitle: String
    let civilTitle: String
    let jobDescription: String
    let postingDate: String
    let agency: String
    let workLocation: String
    let minReqs: String
    let minSalary: String
    init(buisnessTitle: String, civilTitle: String, jobDescription: String, postingDate: String, agency: String, workLocation: String, minReqs: String, minSalary: String) {
        self.buisnessTitle = buisnessTitle
        self.civilTitle = civilTitle
        self.jobDescription = jobDescription
        self.postingDate = postingDate
        self.agency = agency
        self.workLocation = workLocation
        self.minReqs = minReqs
        self.minSalary = minSalary
        
    }


    convenience init?(from dict: [String:Any]) {
        
        let buisnessTitle = dict["business_title"] as? String ?? ""
        let civilTitle = dict["civil_service_title"] as? String ?? ""
        let jobDescription = dict["job_description"] as? String ?? ""
        let postingDate = dict["posting_date"] as? String ?? ""
        let agency = dict["agency"] as? String ?? ""
        let workLocation = dict["work_location"] as? String ?? ""
        let minReqs = dict["minimum_qual_requirements"] as? String ?? ""
        let minSalary = dict["salary_range_from"] as? String ?? ""
        
        let date = Array(postingDate.components(separatedBy: " "))
        
        let description = Array(jobDescription.components(separatedBy: "."))
        let shortDescript = (description[0..<description.count/4]).joined(separator: " ")
        
   
        self.init(buisnessTitle: buisnessTitle, civilTitle: civilTitle, jobDescription: shortDescript, postingDate: date[0], agency: agency, workLocation: workLocation, minReqs: minReqs, minSalary: minSalary)
    }
    
    
     static func getJobs(from arr:[[String:Any]]) -> [NYCJobs] {
        var jobs = [NYCJobs]()
        for job in arr {
            if let job = NYCJobs(from: job)  {
                jobs.append(job)
            }
        }
        return jobs
    
    }

    var asDictionary: [String: String] {
        return ["buisnessTitle": buisnessTitle, "civilTitle": civilTitle, "jobDescription": jobDescription, "postingDate": postingDate, "agency": agency, "workLocation":workLocation, "minReqs": minReqs, "minSalary": minSalary  ]
    }




}
