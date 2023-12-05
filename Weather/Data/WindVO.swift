//
//  WindVO.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation

struct WindVO: Codable {

  var speed : Double? = nil
  var deg   : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case speed = "speed"
    case deg   = "deg"
  
  }
}
