/* DO NOT EDIT | Generated by gyro */

import ObjectMapper

extension Pagination: Mappable {

  // MARK: Initializers
  convenience init?(map: Map) {
    self.init()
  }

  // MARK: Mappable
  func mapping(map: Map) {
    // MARK: Attributes
    self.next <- map["next"]
    self.selff <- map["selff"]
    self.totalEntries.value <- map["totalEntries"]
  }
}
