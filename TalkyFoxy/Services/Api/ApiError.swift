//
//  ApiError.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import Foundation

enum ApiError: String, Error {
    case unknownError = "Неизвестная ошибка, попробуйте позже"
    case forbidden = "Нет доступа"
    case badRequest = "Некорректный запрос"
    case notFound = "Ресурс не найден"
    case unableToConvertData = "Не удалось получить данные"
}
