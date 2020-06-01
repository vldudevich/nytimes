//
//  Movie.swift
//  NyTimes
//
//  Created by vladislav on 26.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class Movie: Codable {

    var displayTitle: String
    var rating: String
    var criticsPick: Int
    var byline: String
    var headline: String
    var summaryShort: String
    var publicationDate: String
    var openingDate: String?
    var dateUpdated: String?
    var link: Link
    var multimedia: Multimedia

    private enum CodingKeys: String, CodingKey {
        case displayTitle = "display_title"
        case rating = "mpaa_rating"
        case criticsPick = "critics_pick"
        case byline = "byline"
        case headline = "headline"
        case summaryShort = "summary_short"
        case publicationDate = "publication_date"
        case openingDate = "opening_date"
        case dateUpdated = "date_updated"
        case link
        case multimedia
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.displayTitle = try container.decode(String.self, forKey: .displayTitle)
        self.rating = try container.decode(String.self, forKey: .rating)
        self.criticsPick = try container.decode(Int.self, forKey: .criticsPick)
        self.byline = try container.decode(String.self, forKey: .byline)
        self.headline = try container.decode(String.self, forKey: .headline)
        self.summaryShort = try container.decode(String.self, forKey: .summaryShort).htmlDecoded
        self.publicationDate = try container.decode(String?.self, forKey: .publicationDate) ?? ""
        self.openingDate = try container.decode(String?.self, forKey: .openingDate) ?? ""
        self.dateUpdated = try container.decode(String?.self, forKey: .dateUpdated) ?? ""
        self.link = try container.decode(Link.self, forKey: .link)
        self.multimedia = try container.decode(Multimedia.self, forKey: .multimedia)
    }
    func parseResponse( responseData: Data, completionHandler: (Review?) -> Void) {
        let decoder = JSONDecoder()
        do {
            let moviesResponse = try decoder.decode(Review.self, from: responseData)
            completionHandler(moviesResponse)
            return
        } catch {
            print(error)
        }
        completionHandler(nil)
    }
}
//class Movie: Codable {
//    
//    var displayTitle: String
//    var rating: String
//    var criticsPick: Int
//    var byline: String
//    var headline: String
//    var summaryShort: String
//    var publicationDate: String
//    var openingDate: String?
//    var link: Link
//    var multimedia: Multimedia
//    
//    private enum CodingKeys: String, CodingKey {
//        case displayTitle = "display_title"
//        case rating = "mpaa_rating"
//        case criticsPick = "critics_pick"
//        case byline = "byline"
//        case headline = "headline"
//        case summaryShort = "summary_short"
//        case publicationDate = "publication_date"
//        case openingDate = "opening_date"
//        case link
//        case multimedia
//    }
//    
//    
//    required init(from decoder: Decoder) throws {
//        
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        let dateFormatter = DateFormatter()
//        
//        self.displayTitle = try container.decode(String.self, forKey: .displayTitle) ?? ""
//        self.rating = try container.decode(String.self, forKey: .rating) ?? ""
//        self.criticsPick = try container.decode(Int.self, forKey: .criticsPick) ?? 0
//        self.byline = try container.decode(String.self, forKey: .byline) ?? ""
//        self.headline = try container.decode(String.self, forKey: .headline) ?? ""
//        self.summaryShort = try container.decode(String.self, forKey: .summaryShort) ?? ""
//        self.openingDate = try container.decodeIfPresent(String?.self, forKey: .openingDate) ?? ""
//        self.link = try container.decode(Link.self, forKey: .link) ?? Link()
//        self.multimedia = try container.decode(Multimedia.self, forKey: .multimedia) ?? Multimedia()
//       
//    }
//    
//    
//}
