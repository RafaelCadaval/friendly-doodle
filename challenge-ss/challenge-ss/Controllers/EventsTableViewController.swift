//
//  EventsTableViewController.swift
//  challenge-ss
//
//  Created by Rafael Cadaval on 04/08/19.
//  Copyright © 2019 Rafael Cadaval. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class EventsTableViewController: UITableViewController {
    var eventsListViewModel: EventsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // This ensures that the constraints of height and anchors can be enforced correctly
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchEvents() {
        guard let url = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events") else {
            fatalError("Incorrect URL")
        }
        
        let resource = Resource<[Event]>(url: url)
        WebService.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let events):
                self?.eventsListViewModel = EventsListViewModel(events)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension EventsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsListViewModel == nil ? 0 : eventsListViewModel.eventsViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = eventsListViewModel.eventViewModel(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as? EventsTableViewCell else { fatalError("Could not dequeue EventsTableViewCell") }
        let processor = DownsamplingImageProcessor(size: CGSize(width: 150, height: 120))
        cell.eventImage.kf.indicatorType = .activity
        cell.eventImage.kf.setImage(with: viewModel.imageURL, placeholder: UIImage(named: "placeholderEventImage"), options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.5))])
        cell.titleLabel.text = viewModel.title
        cell.priceLabel.text = viewModel.price
        
        return cell
    }
}
