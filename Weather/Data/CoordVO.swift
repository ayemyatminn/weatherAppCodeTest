//
//  CoordVO.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation

struct CoordVO: Codable {

  var lon : Double? = nil
  var lat : Double? = nil

  enum CodingKeys: String, CodingKey {

    case lon = "lon"
    case lat = "lat"
  
  }
}
