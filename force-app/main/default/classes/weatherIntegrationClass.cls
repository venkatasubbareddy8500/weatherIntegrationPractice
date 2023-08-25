public class weatherIntegrationClass {
    @AuraEnabled
    public static List<mywrapper> getWeatherInformationBasedOnCity(String cityName){
        list<mywrapper> cityWeatherOverallData = new list<mywrapper>(); 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String weatherUrl = 'https://api.openweathermap.org/data';
        string op = '/2.5/weather?q=';
        string citynme = cityName ;
        string apiset = '&apiKey=';
        string key = '3938ff24436bbd9589300787b5e293c4';
        request.setEndpoint(weatherUrl + op + citynme + apiset + key);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('response-------------->' + response.getStatuscode());
        if(response.getStatusCode() == 200) {
            // for assigning all divided data inside one wrapper class which data you want to add inside wrapper class create instance of the wrapper class
            mywrapper alldata = new mywrapper ();
            
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('results-------------->' + results);
            Map<String, Object> coordResults = (Map<String, Object>)results.get('coord');
            system.debug('coordResults-------------->' + coordResults);
            Decimal lattitude = (Decimal)coordResults.get('lat');
            //assign lattitude to inside wrapperClass
            alldata.cityLatitude = lattitude;
            system.debug('lattitude-------------->'+lattitude);
            Decimal longitude = (Decimal)coordResults.get('lon');
            //assign longitude to inside wrapperClass
            alldata.cityLongitude = longitude;
            system.debug('longitude-------------->'+longitude);
            
            list<object> weatherResults = (list<object>)results.get('weather');
            system.debug('weatherreults-------------->' + weatherResults);
            if(!weatherResults.isEmpty()){
                map<string , object> weatherResultsMapData = (map<string , object>)weatherResults[0];
                system.debug('weatherResultsMapData-------------->' + weatherResultsMapData);
                integer weatherId = (integer)weatherResultsMapData.get('id');
                system.debug('weatherId-------------->' + weatherId);
                String weatherMain = (String)weatherResultsMapData.get('main');
                // assign weatherMain inside a wrapper class
                alldata.cityWeatherMain = weatherMain;
                system.debug('weatherMain-------------->' + weatherMain);
                String weatherDescription = (String)weatherResultsMapData.get('description');
                // assign weatherDescription inside a wrapper class
                alldata.cityWeatherDescription = weatherDescription;
                system.debug('weatherDescription-------------->' + weatherDescription);
                String weatherIcon = (String)weatherResultsMapData.get('icon');
                // assign weatherIcon inside a wrapper class
                alldata.cityWeatherIcon = weatherIcon;
                system.debug('weatherIcon-------------->' + weatherIcon);
            }
         	String baseResults = (String)results.get('base');
            system.debug('baseResults-------------->' + baseResults);
            Map<String, Object> mainResults = (Map<String, Object>)results.get('main');
            system.debug('mainResults-------------->' + mainResults);
            if(!mainResults.IsEmpty()){
                Decimal mainResultsTemparature = (Decimal)mainResults.get('temp');
                // assign mainResultsTemparature inside a wrapper class
                alldata.cityMainResultsTemparature = mainResultsTemparature;
                system.debug('mainResultsTemparature-------------->' + mainResultsTemparature);
                Decimal mainResultsfeelslike = (Decimal)mainResults.get('feels_like');
                system.debug('mainResultsfeelslike-------------->' + mainResultsfeelslike);
                Decimal mainResultstempmin = (Decimal)mainResults.get('temp_min');
                // assign mainResultstempmin inside a wrapper class
                alldata.cityMainResultstempmin = mainResultstempmin;
                system.debug('mainResultstempmin-------------->' + mainResultstempmin);
                Decimal mainResultstempmax = (Decimal)mainResults.get('temp_max');
                // assign mainResultstempmax inside a wrapper class
                alldata.cityMainResultstempmax = mainResultstempmax;
                system.debug('mainResultstempmax-------------->' + mainResultstempmax);
                Integer mainResultsPressure = (Integer)mainResults.get('pressure');
                // assign mainResultsPressure inside a wrapper class
                alldata.cityMainResultsPressure = mainResultsPressure;
                system.debug('mainResultsPressure-------------->' + mainResultsPressure);
                Integer mainResultsHumidity = (Integer)mainResults.get('humidity');
                // assign mainResultsHumidity inside a wrapper class
                alldata.cityMainResultsHumidity = mainResultsHumidity;
                system.debug('mainResultsHumidity-------------->' + mainResultsHumidity);
                Integer mainResultsSealevel = (Integer)mainResults.get('sea_level');
                system.debug('mainResultsSealevel-------------->' + mainResultsSealevel);
                Integer mainResultsGrndlevel = (Integer)mainResults.get('grnd_level');
                system.debug('mainResultsGrndlevel-------------->' + mainResultsGrndlevel);
            }
            Integer visibilityData = (integer)results.get('visibility');
            system.debug('visibilityData-------------->' + visibilityData);
            Map<String, Object> windData = (Map<String, Object>)results.get('wind');
            system.debug('windData-------------->' + windData);
            if(!windData.IsEmpty()){
                Decimal windDataSpeed = (Decimal)windData.get('speed');
                // assign windDataSpeed inside a wrapper class
                alldata.cityWindDataSpeed = windDataSpeed;
                system.debug('windDataSpeed-------------->' + windDataSpeed);
                Integer windDataDeg = (Integer)windData.get('deg');
                system.debug('windDataDeg-------------->' + windDataDeg);
                Decimal windDataGust = (Decimal)windData.get('gust');
                system.debug('windDataGust-------------->' + windDataGust);
            }
            Map<String, Object> cloudsData = (Map<String, Object>)results.get('clouds');
            system.debug('cloudsData-------------->' + cloudsData);
            if(!cloudsData.IsEmpty()){
                Integer cloudsDataAll = (Integer)cloudsData.Get('all');
                // assign cloudsDataAll inside a wrapper class
                alldata.cityCloudsDataAll = cloudsDataAll;
                system.debug('cloudsDataAll-------------->' + cloudsDataAll);
            }
            Integer dt = (Integer)results.get('dt');
            system.debug('dt-------------->' + dt);
            Map<String, Object> sysData = (Map<String, Object>)results.get('sys');
            system.debug('sysData-------------->' + sysData);
            if(!sysData.IsEmpty()){
                String countryName = (String)sysData.get('country');
                // assign countryName inside a wrapper class
                alldata.cityCountryName = countryName;
                system.debug('countryName-------------->' + countryName);
                Integer sunriseData = (Integer)sysData.get('sunrise');
                system.debug('sunriseData-------------->' + sunriseData);
                Integer sunsetData = (Integer)sysData.get('sunset');
                system.debug('sunsetData-------------->' + sunsetData);
                
            }
            Integer timezoneData = (Integer)results.get('timezone');
            // assign timezoneData inside a wrapper class
                alldata.cityTimezoneData = timezoneData;
            system.debug('timezoneData-------------->' + timezoneData);
            Integer cityId = (Integer)results.get('id');
            system.debug('cityId-------------->' + cityId);
            String city = (String)results.get('name');
             // assign cityName inside a wrapper Class
            alldata.cityName = city;
            system.debug('city-------------->' + city);
            integer cityCode = (Integer)results.get('cod');
            system.debug('cityCode-------------->' + cityCode);
            cityWeatherOverallData.add(alldata);
        }
        if(!cityWeatherOverallData.IsEmpty()){
            system.debug('cityWeatherOverallData' + cityWeatherOverallData);
            return cityWeatherOverallData;
        } else 
            return null;
    }
    public class mywrapper{
        @AuraEnabled
        public string cityName{get;set;}
        @AuraEnabled
        public Decimal cityLatitude{get;set;}
        @AuraEnabled
        public Decimal cityLongitude{get;set;}
        @AuraEnabled
        public String cityWeatherMain{get;set;}
        @AuraEnabled
        public String cityWeatherDescription{get;set;}
        @AuraEnabled
        public String cityWeatherIcon{get;set;}
        @AuraEnabled
        public Decimal cityMainResultsTemparature{get;set;}
        @AuraEnabled
        public Decimal cityMainResultstempmin{get;set;}
        @AuraEnabled
        public Decimal cityMainResultstempmax{get;set;}
        @AuraEnabled
        public Integer cityMainResultsPressure{get;set;}
        @AuraEnabled
        public Integer cityMainResultsHumidity{get;set;}
        @AuraEnabled
        public Decimal cityWindDataSpeed{get;set;}
        @AuraEnabled
        public Integer cityCloudsDataAll{get;set;}
        @AuraEnabled
        public String cityCountryName{get;set;}
        @AuraEnabled
        public Integer cityTimezoneData{get;set;}
    }
}