//
//  EventsListViewModel.swift
//  challenge-ss
//
//  Created by Rafael Cadaval on 05/08/19.
//  Copyright © 2019 Rafael Cadaval. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class EventsListViewModel {
    var eventsViewModel: [EventViewModel]
    
    init(_ events: [Event]) {
        self.eventsViewModel = events.compactMap(EventViewModel.init)
    }
    
    func eventViewModel(at index: Int) -> EventViewModel {
        return eventsViewModel[index]
    }
}

struct EventViewModel {
    let event: Event
    
    var title: String {
        return event.title
    }
    var price: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        guard let priceFormatted = currencyFormatter.string(from: NSNumber(value: event.price)) else { return "-" }
        return priceFormatted
    }
    var latitude: StringOrDoubleTypeCase {
        return event.latitude
    }
    var longitude: StringOrDoubleTypeCase {
        return event.longitude
    }
    var image: UIImage {
        var downloadedImage = UIImage()
        let url = URL(string: event.image)!
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let imageResult):
                downloadedImage = imageResult.image
            case .failure(let error):
                // TODO: implement placeholder image case
                fatalError("Could not download image. Kingfisher error: \(error.errorDescription)")
            }
        }
        return downloadedImage
    }
    var description: String {
        return event.description
    }
    var date: String {
        let date = Date(timeIntervalSince1970: Double(event.date)/1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
