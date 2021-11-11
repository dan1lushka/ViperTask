//
//  StringExtensions.swift
//  SBTask
//
//  Created by Daniel Rybak on 08/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
  var hasNotEmptyValue: Bool {
    get {
      return self != "" && self != nil
    }
  }
}
