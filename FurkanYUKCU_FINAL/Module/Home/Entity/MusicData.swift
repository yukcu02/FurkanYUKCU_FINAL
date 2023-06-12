//
//  MusicData.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

public struct MusicData: Codable {
    public let resultCount: Int?
    public let results: [Music]?
    
    public init(resultCount: Int?, results: [Music]?) {
        self.resultCount = resultCount
        self.results = results
    }
}
   public struct Music: Codable {
       public let artworkUrl100: String?
       public let artistName: String?
       public let trackName: String?
       public let trackPrice: Double?
       public let collectionPrice: Double?
       public let primaryGenreName: String?
       public let collectionName: String?
       public let previewURL: String?
       
       enum CodingKeys: String, CodingKey {
           case artistName, collectionName, trackName, previewURL, artworkUrl100, trackPrice, primaryGenreName, collectionPrice
       }
      
       public init(artistName: String?, collectionName: String?, trackName: String?, previewURL: String?, artworkUrl100: String?, collectionPrice: Double?, trackPrice: Double?, primaryGenreName: String?) {
           
           self.artistName = artistName
           self.collectionName = collectionName
           self.trackName = trackName
           self.previewURL = previewURL
           self.artworkUrl100 = artworkUrl100
           self.collectionPrice = collectionPrice
           self.trackPrice = trackPrice
           self.primaryGenreName = primaryGenreName
       }
   }

//public enum Explicitness: String, Codable {
//    case explicit = "explicit"
//    case notExplicit = "notExplicit"
//}
//
//public enum Country: String, Codable {
//    case tur = "TUR"
//}
//
//public enum Currency: String, Codable {
//    case currencyTRY = "TRY"
//}
//
//public enum Kind: String, Codable {
//    case song = "song"
//}
//
//public enum WrapperType: String, Codable {
//    case track = "track"
//}
