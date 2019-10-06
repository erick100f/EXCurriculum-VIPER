//
//  EXCurriculumInteractor.swift
//  EXCurriculum-VIPER
//
//  Created by Erick Cienfuegos on 10/6/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

class EXCurriculumInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    
    func fetchCv() {
        guard let url = URL(string: EXConstants.jsonURL) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) {[weak self] (data, response, error) in
            if HTTP_RESPONSE_DEBUG, let httpResponse = response as? HTTPURLResponse{
                print(httpResponse)
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data  {
               do {
                  let cv = try JSONDecoder().decode(EXCurriculum.self, from: data)
//                  print(cv.name)
                  self?.presenter?.cvFetchedSuccess(cv: cv)
                
               } catch let error {
                    print(error)
                  self?.presenter?.cvFetchFailed()
               }
            }
        }.resume()
    }
    
}
