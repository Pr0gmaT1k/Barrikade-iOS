//
//  BarrikadeWSClient.swift
//  Barrikade-iOS
//
//  Created by Pr0gmaT1K on 18/01/2018.
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

import RxSwift
import Alamofire
import NetworkStack
import ObjectMapper

final class BarrikadeWSClient {
  // MARK: - Properties
  static let baseURL = "https://barrikade.info/"
  private static let appName = "barrikade_info"
  private static let keychainService = KeychainService(serviceType: BarrikadeWSClient.appName)
  private static let networkStack = NetworkStack(baseURL: BarrikadeWSClient.baseURL, keychainService: keychainService)


  // Mark:- Services
  func getNews(startAt: Int) -> Observable<Void> {
    print(BarrikadeRoute.articleCollection(startAt: 0).path)
    let requestParameters = RequestParameters(method: .get,
                                              route: BarrikadeRoute.articleCollection(startAt: startAt))

    return BarrikadeWSClient.networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters)
      .map({ (_, json) -> Void in
        let articleCollection = Mapper<ArticleCollection>().map(JSONObject: json)
        print(articleCollection)
      })
  }
}
