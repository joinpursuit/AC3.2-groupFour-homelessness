//
//  FileManager.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import Foundation
import UIKit

class EmployedFileManager{
    private let manager: FileManager = FileManager.default
    private let rootFolderName: String = "Employed"
    private var rootURL: URL!
    private var resumeUrl: URL!
    
    private init (){
        do {
            // define a rootURL using url(for:in:appropriateFor:create:true)
            self.rootURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            //check that we can find the folder using rootURL
            // check that we can actually found it, but how?
            
            // create & define a Blockground Images URL relative to the root
            resumeUrl = URL(string: rootFolderName, relativeTo: rootURL)!
            try manager.createDirectory(at: resumeUrl, withIntermediateDirectories: true, attributes: nil)
            
        }catch{
            print("Error encounterd locayion a rootURL: \(error)")
        }
        
    }

    static let shared: EmployedFileManager = EmployedFileManager()
    
    
    func convertToPDf(image: UIImage,horizontalResolution: Double = 72, verticalResolution: Double = 72)-> NSData?{
        
        let defaultResolution: Int = 72
        
        if horizontalResolution <= 0 || verticalResolution <= 0 {
            return nil;
        }
        
        let pageWidth: Double = Double(image.size.width) * Double(image.scale) * Double(defaultResolution) / horizontalResolution
        let pageHeight: Double = Double(image.size.height) * Double(image.scale) * Double(defaultResolution) / verticalResolution
        
        let pdfFile: NSMutableData = NSMutableData()
        
        let pdfConsumer: CGDataConsumer = CGDataConsumer(data: pdfFile as CFMutableData)!
        
        var mediaBox: CGRect = CGRect(x: 0, y: 0, width: CGFloat(pageWidth), height: CGFloat(pageHeight))//CGSize(0, 0, CGFloat(pageWidth), CGFloat(pageHeight))
        
        let pdfContext: CGContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(image.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        return pdfFile
        
    }
    
    func saveFile(data: NSData){
        
        let resumePath = resumeUrl.appendingPathComponent("employedResume.pdf")
        
        do{
            try data.write(to: resumePath)
            
        }catch{
            print("Error ===> \(error.localizedDescription)")
        }
    }
    
    func retreivePDF()-> URL?{
        
        let fileURL = resumeUrl.appendingPathComponent("employedResume.pdf")

        return fileURL.absoluteURL
    }
    
    
}
