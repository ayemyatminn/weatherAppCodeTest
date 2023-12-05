//
//  WeatherVO.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation

struct WeatherVO: Codable {

  var id          : Int?    = nil
  var main        : String? = nil
  var description : String? = nil
  var icon        : String? = nil

  enum CodingKeys: String, CodingKey {

    case id          = "id"
    case main        = "main"
    case description = "description"
    case icon        = "icon"
  
  }
}
