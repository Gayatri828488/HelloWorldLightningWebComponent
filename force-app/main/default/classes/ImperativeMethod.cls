public with sharing class ImperativeMethod {
    // Constructor
    @AuraEnabled(cacheable=true)

    // Method to get contacts
    public static List<Account> getAccount() {
        List<Account> accList = [SELECT Id ,Name , (SELECT LastName, AccountId FROM Contacts) From Account Limit 5];
        return accList;
    }
}