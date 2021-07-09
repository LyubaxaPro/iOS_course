import Foundation

struct CitiesResponse: Decodable {
    let list: [CityResponse]
}

struct CityResponse: Decodable {
    let name: String
    let id: Int
    let weather: [CityWeatherInfo]
    let main: CityMainInfo
    let sys: CitySysInfo
}

struct CityMainInfo: Decodable {
    let temp: Float
    let feelsLike: Float
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case temp
    }
}

struct CitySysInfo: Decodable {
    let timezone: Int
}

struct CityWeatherInfo: Decodable {
    let description: String
    let icon: String
}

