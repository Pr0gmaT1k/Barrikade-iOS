/* DO NOT EDIT | Generated by gyro */

import ObjectMapper

extension ArticleCollection: Mappable {

  // MARK: Initializers
  convenience init?(map: Map) {
    self.init()
  }

  // MARK: Mappable
  func mapping(map: Map) {

    // MARK: Relationships
    self.data <- map["data"]
    self.pagination <- map["pagination"]
  }
}
