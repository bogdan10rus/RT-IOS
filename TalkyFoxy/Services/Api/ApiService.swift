//
//  ApiService.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import RxSwift
import Alamofire
import RxAlamofire
import ObjectMapper

protocol ApiServiceProtocol {
    func getTasksList() -> Observable<[TaskObject]>
    func postTaskDialog(dialog: TaskDialogObject) -> Observable<TaskResultObject>
}

class ApiService: BaseApiService, ApiServiceProtocol {
    func getTasksList() -> Observable<[TaskObject]> {
        let request = ApiRequest(path: baseURL + "tasks")
        return callAPIRequest(request: request)
    }
    
    func postTaskDialog(dialog: TaskDialogObject) -> Observable<TaskResultObject> {
        let request = ApiRequest(method: .post, path: baseURL + "dialogs", parameters: dialog.toJSON())
        return callAPIRequest(request: request).debug()
    }
}

class BaseApiService {
    fileprivate let baseURL = "https://rt.sysdyn.ru/api/"

    fileprivate func callAPIRequest<T: BaseMappable>(request: ApiRequest) -> Observable<T> {
        RxAlamofire.requestJSON(request.method, request.path, parameters: request.parameters, encoding: request.encoding, headers: request.headers)
            .flatMap { (_, json) -> Observable<T> in
                guard let json = json as? [String: Any] else { throw ApiError.unableToConvertData }
                guard let model = Mapper<T>().map(JSON: json) else { throw ApiError.unableToConvertData }

                return .just(model)
            }
    }
    
    
    fileprivate func callAPIRequest<T: BaseMappable>(request: ApiRequest) -> Observable<[T]> {
        RxAlamofire.requestJSON(request.method, request.path, parameters: request.parameters, encoding: request.encoding, headers: request.headers)
            .flatMap { (_, json) -> Observable<[T]> in
                guard let model = Mapper<T>().mapArray(JSONObject: json) else { throw ApiError.unableToConvertData }

                return .just(model)
            }
    }
}
