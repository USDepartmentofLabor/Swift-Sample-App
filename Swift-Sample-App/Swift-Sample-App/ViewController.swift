//
//  ViewController.swift
//  Swift-Sample-App
//
//  Created by Michael Pulsifer on 6/24/14.
//  Copyright (c) 2014 U.S. Department of Labor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GovDataRequestProtocol {
                            
    @IBOutlet var appsTableView : UITableView!
    // Create an array to hold the table view data
    var tableData: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize the SDK
        var firstRequest: GovDataRequest = GovDataRequest(APIKey: "", APIHost: "http://api.dol.gov", APIURL: "/V1")
        
        // Set this class to be the SDK's delegate
        firstRequest.delegate = self
        
        // Create an empty dictionary for the arguments
        var arguments = Dictionary<String, String>()
        
        // Set the timeOut to be 60.0 (optional)
        firstRequest.timeOut = 60.0
        
        // Submit the request
        firstRequest.callAPIMethod(method: "DOLAgency/Agencies", arguments: arguments)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.textLabel.text = rowData["Agency"] as String
        
        var agencyName: NSString = rowData["AgencyFullName"] as NSString
        
        cell.detailTextLabel.text = agencyName
        
        return cell
    }

    func didCompleteWithError (errorMessage: String) {
        NSLog("error")
        
    }
    
    func didCompleteWithDictionary (results:NSDictionary) {
        var resultsDictionary: NSDictionary = results["d"] as NSDictionary
        var resultsArray: NSArray = resultsDictionary["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = resultsArray
            self.appsTableView.reloadData()
            })
        
        
    }
    
    func didCompleteWithXML(results: XMLIndexer) {
        
        
    }
}

