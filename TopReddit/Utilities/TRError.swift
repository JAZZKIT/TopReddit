//
//  TRError.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import Foundation

enum TRError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
