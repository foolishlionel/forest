//
//  WeatherApi.swift
//  day21
//
//  Created by flion on 2019/1/31.
//  Copyright © 2019 flion. All rights reserved.
//

import Moya

enum WeatherApi {
    case air
    case alarm
    case weather
}

extension WeatherApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://free-api.heweather.net/s6")!
    }
    
    var path: String {
        switch self {
        case .air:
            return "air"
        case .alarm:
            return "alarm"
        case .weather:
            return "weather"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}


