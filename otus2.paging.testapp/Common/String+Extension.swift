//
//  String+Extension.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import UIKit

extension String {
    func urlEncoded() -> String {
        return self
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)?
            .replacingOccurrences(of: "%20", with: "+") ?? ""
    }
}
