//
//  MainVO.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation

struct MainVO: Codable {

  var temp      : Double? = nil
  var feelsLike : Double? = nil
  var tempMin   : Double? = nil
  var tempMax   : Double? = nil
  var pressure  : Int?    = nil
  var humidity  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case temp      = "temp"
    case feelsLike = "feels_like"
    case tempMin   = "temp_min"
    case tempMax   = "temp_max"
    case pressure  = "pressure"
    case humidity  = "humidity"
  
  }
}
