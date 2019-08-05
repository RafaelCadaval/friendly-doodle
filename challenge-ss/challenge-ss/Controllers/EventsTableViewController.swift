//
//  EventsTableViewController.swift
//  challenge-ss
//
//  Created by Rafael Cadaval on 04/08/19.
//  Copyright © 2019 Rafael Cadaval. All rights reserved.
//

import Foundation
import UIKit

class EventsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchEvents()
    }
    
    private func fetchEvents() {
        guard let url = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events") else {
            fatalError("Incorrect URL")
        }
        
        let resource = Resource<[Event]>(url: url)
        WebService.load(resource: resource) { result in
            switch result {
            case .success(let events):
                print(events)
            case .failure(let error):
                print(error)
            }
        }
    }
}
