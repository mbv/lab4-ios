//
//  Protocols.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import Foundation

protocol WeatherReloadAsyncDelegate {
    func reloadWeather()
    func onError()
}

protocol ShowErrorDelegate {
    func showError()
}
