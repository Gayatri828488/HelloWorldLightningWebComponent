public with sharing class ModalChildComponent {
  @AuraEnabled
    public static void applyHoliday(String holidayData){
     
      // Deserialize the JSON string into a UserHolidayInput object
      HolidayDataWrapper holidayInput =  (HolidayDataWrapper) System.JSON.deserialize(holidayData, HolidayDataWrapper.class);
      // Create the User_Holiday__c record
      
      User_Holiday__c holidayRecord = new User_Holiday__c();
      holidayRecord.Holiday_Type__c= holidayInput.holidayType;
      holidayRecord.Start_Date__c = holidayInput.startDate;
      holidayRecord.End_Date__c = holidayInput.endDate;
      holidayRecord.Name = holidayInput.name;
     
      // User_Holiday__c record
      try {
        insert  holidayRecord;
       } catch (Exception e) {
        throw new AuraHandledException('Failed to apply holiday: ' + e.getMessage());
       }
    }

  //  Wrapper class to represent the holiday data
public  class HolidayDataWrapper{
 
 @AuraEnabled public  String holidayType{get;set;}
  @AuraEnabled public  Date startDate{get;set;}
  @AuraEnabled public  Date endDate{get;set;}
  @AuraEnabled public  String name{get;set;}  
}
}







  
 
      
    
    
 


