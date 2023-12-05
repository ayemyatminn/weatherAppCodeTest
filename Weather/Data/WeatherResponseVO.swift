//
//  WeatherResponseVO.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation

struct WeatherResponseVO: Codable {

  var coord      : CoordVO?     = CoordVO()
  var weather    : [WeatherVO]? = []
  var base       : String?      = nil
  var main       : MainVO?      = MainVO()
  var visibility : Int?         = nil
  var wind       : WindVO?      = WindVO()
  var clouds     : CloudVO?     = CloudVO()
  var dt         : Int?         = nil
  var sys        : SysVO?       = SysVO()
  var timezone   : Int?         = nil
  var id         : Int?         = nil
  var name       : String?      = nil
  var cod        : Int?         = nil

  enum CodingKeys: String, CodingKey {

    case coord      = "coord"
    case weather    = "weather"
    case base       = "base"
    case main       = "main"
    case visibility = "visibility"
    case wind       = "wind"
    case clouds     = "clouds"
    case dt         = "dt"
    case sys        = "sys"
    case timezone   = "timezone"
    case id         = "id"
    case name       = "name"
    case cod        = "cod"
  
  }

}
