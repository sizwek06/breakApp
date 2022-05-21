//
//  QuoteManagerDelegate.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/21.
//

import Foundation

protocol QuoteManagerDelegate {
    func didUpdateCurrentQuote(_ quoteManager: QuoteManager, quoteModel: QuoteModel)
    func didFailWithError(error: Error)
}
