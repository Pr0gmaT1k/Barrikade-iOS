/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class News: Object {

  enum Attributes: String {
    case chapo = "chapo"
    case date = "date"
    case descriptionn = "descriptionn"
    case id = "id"
    case id_rubrique = "id_rubrique"
    case logo = "logo"
    case selff = "selff"
    case soustitre = "soustitre"
    case surtitre = "surtitre"
    case texte = "texte"
    case title = "title"
  }

  dynamic var chapo: String?
  dynamic var date: String?
  dynamic var descriptionn: String?
  dynamic var id: String?
  dynamic var id_rubrique: String?
  dynamic var logo: String?
  dynamic var selff: String?
  dynamic var soustitre: String?
  dynamic var surtitre: String?
  dynamic var texte: String?
  dynamic var title: String?

  override static func primaryKey() -> String? {
    return "id"
  }

}
