struct CitiesServiceHelper {
    private var cities: [CityServiceInfo]
    
    private var urlString: String {
        var ids = cities.reduce("",  { res, current in
            return res + current.id + ","
        })
        
        if ids.last == "," {
            _ = ids.popLast()
        }
        
        return "https://api.openweathermap.org/data/2.5/group?id=\(ids)&units=metric&appid=\(CitiesManager.appId)"
    }
    
    init(cities: [CityServiceInfo]) {
        self.cities = cities
    }
    
    func citiesUrl() -> String {
        return urlString
    }
}

struct CityServiceInfo {
    let name: String
    let id: String
}

