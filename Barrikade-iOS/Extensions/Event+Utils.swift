//
//  Event+Utils.swift
//  Barrikade-iOS
//
//  Created by Pr0gmaT1K on 08/03/2018.
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

import UIKit

extension Event {
    private static let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ", locale: "fr_FR")
    
    /**
     dateObject is used to sort news by date in a sequence of News
     :return: French date corresponding to 'date' propertie, 1 jan 1970 if 'date' propertie is nil or format incorrect. Basically, retrograde the news a the end of the array after a sort by date
     */
    var dateObject: Date {
        guard let date = self.start else { return Date(timeIntervalSince1970: 0) }
        return Event.dateFormatter.date(from: date) ?? Date(timeIntervalSince1970: 0)
    }
}
