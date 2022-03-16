/**
 * @description       : 
 * @author            : Prashant Wayal
 * @group             : 
 * @last modified on  : 02-10-2022
 * @last modified by  : Prashant Wayal
**/
//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//
// The supplied json has fields with names that are not valid in apex
// and so can only be parsed with explicitly generated code, this option
// was auto selected for you.

public class StockExchangeData {

	@AuraEnabled public Dataset dataset {get;set;} 

	public StockExchangeData(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'dataset') {
						dataset = new Dataset(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'StockExchangeData consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Dataset {
		@AuraEnabled public Integer id {get;set;} 
		@AuraEnabled public String dataset_code {get;set;} 
		@AuraEnabled public String database_code {get;set;} 
		@AuraEnabled public String name {get;set;} 
		@AuraEnabled public String description {get;set;} 
		@AuraEnabled public String refreshed_at {get;set;} 
		@AuraEnabled public String newest_available_date {get;set;} 
		@AuraEnabled public String oldest_available_date {get;set;} 
		@AuraEnabled public List<String> column_names {get;set;} 
		@AuraEnabled public String frequency {get;set;} 
		@AuraEnabled public String type {get;set;} 
		@AuraEnabled public Boolean premium {get;set;} 
		@AuraEnabled public Object limit_Z {get;set;} // in json: limit
		@AuraEnabled public Object transform {get;set;} 
		@AuraEnabled public Object column_index {get;set;} 
		@AuraEnabled public String start_date {get;set;} 
		@AuraEnabled public String end_date {get;set;} 
		@AuraEnabled public List<List<String>> data {get;set;} 
		@AuraEnabled public Object collapse {get;set;} 
		@AuraEnabled public Object order {get;set;} 
		@AuraEnabled public Integer database_id {get;set;} 

		public Dataset(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'dataset_code') {
							dataset_code = parser.getText();
						} else if (text == 'database_code') {
							database_code = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'refreshed_at') {
							refreshed_at = parser.getText();
						} else if (text == 'newest_available_date') {
							newest_available_date = parser.getText();
						} else if (text == 'oldest_available_date') {
							oldest_available_date = parser.getText();
						} else if (text == 'column_names') {
							column_names = arrayOfString(parser);
						} else if (text == 'frequency') {
							frequency = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'premium') {
							premium = parser.getBooleanValue();
						} else if (text == 'limit') {
							limit_Z = parser.readValueAs(Object.class);
						} else if (text == 'transform') {
							transform = parser.readValueAs(Object.class);
						} else if (text == 'column_index') {
							column_index = parser.readValueAs(Object.class);
						} else if (text == 'start_date') {
							start_date = parser.getText();
						} else if (text == 'end_date') {
							end_date = parser.getText();
						} else if (text == 'data') {
							data = arrayOfList(parser);
						} else if (text == 'collapse') {
							collapse = parser.readValueAs(Object.class);
						} else if (text == 'order') {
							order = parser.readValueAs(Object.class);
						} else if (text == 'database_id') {
							database_id = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Dataset consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static StockExchangeData parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new StockExchangeData(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	





    private static List<List<String>> arrayOfList(System.JSONParser p) {
        List<List<String>> res = new List<List<String>>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(arrayOfString(p));
        }
        return res;
    }


    private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }


}