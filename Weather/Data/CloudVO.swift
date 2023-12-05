//
//  CloudVO.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation

struct CloudVO: Codable {

  var all : Int? = nil

  enum CodingKeys: String, CodingKey {

    case all = "all"
  
  }
    
}
