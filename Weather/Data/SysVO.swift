//
//  SysVO.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation

struct SysVO: Codable {

  var type    : Int?    = nil
  var id      : Int?    = nil
  var country : String? = nil
  var sunrise : Int?    = nil
  var sunset  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case type    = "type"
    case id      = "id"
    case country = "country"
    case sunrise = "sunrise"
    case sunset  = "sunset"
  
  }
}
