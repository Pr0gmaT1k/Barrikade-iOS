/* DO NOT EDIT | Generated by gyro */

import ObjectMapper

extension EventCollection: Mappable {

  // MARK: Initializers
  convenience init?(map: Map) {
    self.init()
  }

  // MARK: Mappable
  func mapping(map: Map) {

    // MARK: Relationships
    self.data <- (map["data"], ListTransform<Event>())
    self.pagination <- map["pagination"]
  }
}
