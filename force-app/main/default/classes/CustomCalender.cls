public with sharing class CustomCalender {
   @AuraEnabled
    public static List<User_Holiday__c> getUserHolidayData(){
        List<User_Holiday__c> holidayDataList = [Select Id, Name, Start_Date__c,End_Date__c,Holiday_Type__c From User_Holiday__c];
        return holidayDataList ;
      }
}