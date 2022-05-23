//
//  DataService.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation

enum FetchDataError: Error {
  case invalidPath
  case emptyFile
}

class DataService {

  let configuration: Configuration

  init(configuration: Configuration) {
    self.configuration = configuration
  }

  private func fetchData<T>(
    from fileName: String,
    ofType type: FileType,
    completion: ((Result<T, Error>) -> Void)
  ) where T: Decodable {
    do {
      if let filePath = Bundle.main.path(forResource: fileName, ofType: type.rawValue) {
        if let data = try String(contentsOfFile: filePath).data(using: .utf8) {

          // TODO: Parsing should be done in separate implementation based on file type.
          let jsonDecoder = JSONDecoder()
          let decodedData = try jsonDecoder.decode(T.self, from: data)
          completion(.success(decodedData))
        } else {
          completion(.failure(FetchDataError.emptyFile))
        }
      } else {
        completion(.failure(FetchDataError.invalidPath))
      }
    } catch {
      completion(.failure(error))
    }
  }

  private func storeData(
    _ data: Data,
    inFile fileName: String,
    ofType: FileType,
    completion: ((Bool) -> Void)
  ) {
    // Save data in json file.
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectoryPath = paths[0]

    // TODO: Move the unique file creation logic at proper place.
    let filePath = documentsDirectoryPath.appendingPathComponent("\(fileName)_\(UUID().uuidString)")

    do {
      try data.write(to: filePath)
      completion(true)
    } catch {
      print("Error writing to JSON file: \(error)")
      completion(false)
    }
  }

}

extension DataService: DataHandler {

  func fetchStoreInfo(completion: ((Result<StoreInfoResponse, Error>) -> Void)) {
    fetchData(from: configuration.fileName, ofType: configuration.fileType, completion: completion)
  }

  func fetchProducts(completion: ((Result<ProductsResponse, Error>) -> Void)) {
    fetchData(from: configuration.fileName, ofType: configuration.fileType, completion: completion)
  }

  func storeOrder(_ order: Order, completion: ((Bool) -> Void)) {

    switch configuration.fileType {
    case .json:
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(order) {
        storeData(
          encoded, inFile:
          configuration.fileName,
          ofType: configuration.fileType,
          completion: completion
        )
      } else {
        print("Cannot encode the order.")
        completion(false)
      }
    }
  }
}
