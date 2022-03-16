/**
 * @description       : 
 * @author            : Prashant Wayal
 * @group             : 
 * @last modified on  : 03-16-2022
 * @last modified by  : Prashant Wayal
**/
public class StockExchangeDataController {
	

    /**
    * @description : Get the stocks data from BSE 
    * @author Prashant Wayal | 02-11-2022 
    * @param String bseCode 
    * @return StockExchangeData 
    **/
    @AuraEnabled
    public static StockExchangeData getStockData(String bseCode) {
        //Create HttpRequest object
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Label.Endpoint);
        req.setMethod('GET');
        
        // Create a new http object to send the request object
        // A response object is generated as a result of the request  
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('*** Response *** '+ res.getBody());
        String responseBody = res.getBody();
        StockExchangeData data = StockExchangeData.parse(responseBody);
		System.assert(data != null);
		return data;
    }
}