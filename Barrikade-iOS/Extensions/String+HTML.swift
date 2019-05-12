//
//  String+HTML.swift
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

extension String {
    var removeHTMLParagraph: String {
        return self.replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<i>", with: "")
            .replacingOccurrences(of: "</i>", with: "")
    }

    var removeBarrikadeSpecific: String {
        return self.removeHTMLParagraph.replacingOccurrences(of: "<br class='autobr' />", with: "")
                                       .replacingOccurrences(of: "<strong>", with: "")
                                       .replacingOccurrences(of: "</strong>", with: "")
                                       .replacingOccurrences(of: "<h3 class=\"spip\">", with: "")
                                       .replacingOccurrences(of: "</h3>", with: "")
    }
}
