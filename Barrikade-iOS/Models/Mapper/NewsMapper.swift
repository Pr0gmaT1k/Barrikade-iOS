/* DO NOT EDIT | Generated by gyro */

import ObjectMapper

extension News: Mappable {

  // MARK: Initializers
  convenience init?(map: Map) {
    self.init()
  }

  // MARK: Mappable
  func mapping(map: Map) {
    // MARK: Attributes
    self.id.value <- map["id"]
    self.chapo <- map["chapo"]
    self.date <- map["date"]
    self.descriptionn <- map["description"]
    self.id_rubrique <- map["id_rubrique"]
    self.logo <- map["logo"]
    self.selff <- map["self"]
    self.soustitre <- map["soustitre"]
    self.surtitre <- map["surtitre"]
    self.texte <- map["texte"]
    self.title <- map["title"]
  }
}
