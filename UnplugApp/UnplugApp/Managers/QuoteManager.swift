//
//  QuoteManager.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/21.
//

import Foundation

struct QuoteManager {
    var delegate: QuoteManagerDelegate?
    
    let baseURL = "https://type.fit/api/quotes"
    
    func getQuote() {
        let urlString = baseURL
        
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {(data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        delegate?.didFailWithError(error: error!)
                        return
                    }
                    if let safeData = data {
                        if let quote = self.parseJSON(safeData) {
                            self.delegate?.didUpdateCurrentQuote(self, quoteModel: quote)
                        }
                    }
                }
            }
            task.resume()
            }
    }
    
    func parseJSON(_ quoteData: Data) -> QuoteModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([QuoteData].self, from: quoteData)
            let randomQuoteIndex = Int.random(in: 0..<decodedData.count)
            print("Array num: \(randomQuoteIndex)")
            //TODO: REMOVE: Print is for testing purposes - quoteLabel word wrap
            let text = decodedData[randomQuoteIndex].text
            let author = decodedData[randomQuoteIndex].author
            
            let quote = QuoteModel(text: text, author: author)
            return quote
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
