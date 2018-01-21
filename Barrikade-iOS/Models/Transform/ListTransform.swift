//
//  ListTransform.swift
//  Barrikade-iOS
//
//  Created by Pr0gmaT1K on on 14/01/2018.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import ObjectMapper
import RealmSwift

class ListTransform<T: RealmSwift.Object> : TransformType where T: Mappable {
    typealias Object = List<T>
    typealias JSON = [AnyObject]

    let mapper = Mapper<T>()

    func transformFromJSON(_ value: Any?) -> List<T>? {
        let results = List<T>()
        if let value = value as? [AnyObject] {
            for json in value {
                if let obj = mapper.map(JSONObject: json) {
                    results.append(obj)
                }
            }
        }
        return results
    }

    func transformToJSON(_ value: Object?) -> [AnyObject]? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json as AnyObject)
            }
        }
        return results
    }
}
