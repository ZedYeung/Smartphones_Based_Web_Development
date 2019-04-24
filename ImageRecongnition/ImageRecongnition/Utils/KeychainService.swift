//
//  KeychainService.swift
//  InstaHappy
//
//  Created by Zed on 4/18/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import KeychainSwift


class KeychainService{
    var _keyChain = KeychainSwift()
    var keyChain: KeychainSwift{
        get{
            return _keyChain
        }
        set{
            _keyChain = newValue
        }
    }
}
