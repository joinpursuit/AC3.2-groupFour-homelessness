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
    
    
    func convertToPDf(image: UIImage)-> NSData?{
        
        let width = CameraOverlayView.paperSizeA5.width
        let height = CameraOverlayView.paperSizeA5.height
        
        let horizontalResolution: Double = Double(width)
        let verticalResolution: Double = Double(height)
        
        guard let croppedImage = cropImage(image: image, width: 1000, height: 1000) else {return nil}
        
        //let defaultResolution: Int = 72
        
        if horizontalResolution <= 0 || verticalResolution <= 0 {
            return nil;
        }
        
//        let pageWidth: Double = Double(croppedImage.size.width) * Double(image.scale) * Double(defaultResolution) / horizontalResolution
//        let pageHeight: Double = Double(croppedImage.size.height) * Double(image.scale) * Double(defaultResolution) / verticalResolution
        
        let pageWidth = width * 3
        let pageHeight = height * 3
        let pdfFile: NSMutableData = NSMutableData()
        
        let pdfConsumer: CGDataConsumer = CGDataConsumer(data: pdfFile as CFMutableData)!
        
        var mediaBox: CGRect = CGRect(x: 0, y: 0, width: CGFloat(pageWidth), height: CGFloat(pageHeight))//CGSize(0, 0, CGFloat(pageWidth), CGFloat(pageHeight))
        
        let pdfContext: CGContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(croppedImage.cgImage!, in: mediaBox)
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
    
    private func cropImage(image: UIImage, width: Int, height: Int) -> UIImage? {
        // Cropping is available trhough CGGraphics
        let toRect = CGRect(x: 0, y: 0, width: width * 3, height: height * 3)
        let cgImage :CGImage! = image.cgImage
        let croppedCGImage: CGImage! = cgImage.cropping(to: toRect)
        
        
        return UIImage(cgImage: croppedCGImage)
    }
    
    
}
