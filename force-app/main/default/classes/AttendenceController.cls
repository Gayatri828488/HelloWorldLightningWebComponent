// public with sharing class AttendenceController {
    //   @AuraEnabled
    //     public static DateTIME  punchIn( String currentDTime ){
    //    Attendence ac = new Attendence();
    
    //     String loggedInUserName = UserInfo.getUserName();
    //    Employee__c  employee  =[Select  ID , Name_c From Employee__c  Where Name__c =:loggedInUserName];
       
    //    Attendance__c newAttendance = new Attendance__c();
    //    newAttendance.Name__c = employee.Name;
    //    newAttendance.Punch_In_Time__c = currentTime;
    //    insert newAttendance;
    //     }
    //     return punchIn;
    //  }

    
    
    // public class AttendanceController {
    //     @AuraEnabled 
    //             // Method to handle Punch In without needing to pass the userId
    //             public static void HandlePunchIn(){
    //                 // Get the current user ID
    //                 String loggedInUserName = UserInfo.getUserName();
    //                 Employee__c  employee = [Select  ID , Name__c From Employee__c Where Name__c =:loggedInUserName];
                    
    //                 // Get the current date and time
    //                 DateTime currentDTime = DateTime.now();
    //                 String employeeName = employee.Name;
    //                 Integer currentMonth = currentDTime.month();
    //                 Integer currentYear = currentDTime.year();
                    
    //                 // Step 1: Check if a Monthly Attendance record exists for the current user and the current month
    //                 Monthly_Attendance__c monthlyAttendance = getMonthlyAttendance(employee.Name__c, currentMonth, currentYear);
                    
    //                 if (monthlyAttendance == null) {
    //                     // Step 2: If no Monthly Attendance record exists, create one
                    
                        
    //                     // Fetch the Employee record based on the logged-in user name
                       
    //                      monthlyAttendance = new Monthly_Attendance__c();
    //                     monthlyAttendance.Employee__c = employeeName; // Ensure Name__c exists in Monthly_Attendance__c
    //                     monthlyAttendance.Month__c = String.valueOf(currentMonth);
    //                     monthlyAttendance.Year__c = String.valueOf(currentMonth);
                        
            
    //                     try {
    //                         insert monthlyAttendance;
    //                     } catch (DmlException e) {
    //                         System.debug('Error inserting Monthly Attendance: ' + e.getMessage());
    //                         return; // Exit if insert fails
    //                     }
    //                 }
    //                 List <Attendance__c>Attendencerecord = new List<Attendance__c>();
    //                 // Step 3: Create the Attendance record related to the Monthly Attendance
    //                 Attendance__c attendance = new Attendance__c();
    //                 attendance.Monthly_Attendance__c = monthlyAttendance.Id; // Link to the Monthly Attendance
    //                 attendance.Punch_In_Time__c = currentDTime;
    //                 attendance.Employee__c = employee.Id ;
    //                 Attendencerecord.add(attendance);

                    
                        
    //         if(!Attendencerecord.isEmpty()){
    //             insert Attendencerecord;
    //         }
            
                       
                
            
    //             // Method to retrieve Monthly Attendance record for the current user and month
    //             private static Monthly_Attendance__c getMonthlyAttendance( Id employeeId, Integer month, Integer year) {
    //                 Monthly_Attendance__c records = [SELECT Id FROM Monthly_Attendance__c 
    //                                                         Employee__c = :employeeId
    //                                                          AND Month__c = :month
    //                                                         AND Year__c = :year 
    //                                                         LIMIT 1];
    //                 return records.isEmpty() ? null : records[0];
    //             }
    //         }
    //     }          


//     public without sharing class AttendenceController {

//         @AuraEnabled
//         public static DateTime PunchIn() {
//             String loggedInUserName = UserInfo.getName();
//             Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE Name__c = :loggedInUserName LIMIT 1];
    
//             if (employee == null) {
//                 System.debug('Employee not found for the current user.');
//                 return null; // Return null if no employee found
//             }
    
//             // Get the current date and time
//             DateTime currentDTime = DateTime.now();
//             Integer currentMonth = currentDTime.month();
//             Integer currentYear = currentDTime.year();
    
//             DateTime startOfDay = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0)); // Start of the day (00:00:00)
//             DateTime endOfDay = DateTime.newInstance(Date.today(), Time.newInstance(23, 59, 59, 999)); // End of the day (23:59:59)
    
//             List<Attendance__c> existingAttendance = [SELECT Id, Punch_in__c 
//                                                       FROM Attendance__c 
//                                                       WHERE Employee__c = :employee.Id 
//                                                       AND Punch_in__c >= :startOfDay 
//                                                       AND Punch_in__c <= :endOfDay 
//                                                       LIMIT 1];
            
//             if (!existingAttendance.isEmpty()) {                               
//                 return existingAttendance[0].Punch_in__c; // Return existing punch-in time if found
//             }
    
//             return null; // Return null if no attendance found
//         }

          
//           @AuraEnabled
//         public static DateTime punchOut() {
//             String loggedInUserName = UserInfo.getName();
//             Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE Name__c = :loggedInUserName LIMIT 1];
    
//             if (employee == null) {
//                 System.debug('Employee not found for the current user.');
//                 return null; // Return null if no employee found
//             }
    
//             // Get the current date and time
//             DateTime currentDTime = DateTime.now();
//             Integer currentMonth = currentDTime.month();
//             Integer currentYear = currentDTime.year();
    
//             DateTime startOfDay = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0)); // Start of the day (00:00:00)
//             DateTime endOfDay = DateTime.newInstance(Date.today(), Time.newInstance(23, 59, 59, 999)); // End of the day (23:59:59)
    
//             List<Attendance__c> existingAttendance = [SELECT Id, Punch_Out__c
//                                                       FROM Attendance__c 
//                                                       WHERE Employee__c = :employee.Id 
//                                                       AND Punch_in__c >= :startOfDay 
//                                                       AND Punch_in__c <= :endOfDay 
//                                                       LIMIT 1];
            
//             if (!existingAttendance.isEmpty()) {                               
//                 return existingAttendance[0].Punch_Out__c; // Return existing punch-in time if found
//             }
    
//             return null; // Return null if no attendance found
//         }
    
//         @AuraEnabled
//         public static DateTime CreatePunchInRecord() {
//             String loggedInUserName = UserInfo.getName();
//             Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE Name__c = :loggedInUserName LIMIT 1];
    
//             if (employee == null) {
//                 System.debug('Employee not found for the current user.');
//                 return null; // Return null if no employee found
//             }
    
//             // Get the current date and time
//             DateTime currentDTime = DateTime.now();
//             Integer currentMonth = currentDTime.month();
//             Integer currentYear = currentDTime.year();
    
//             // Step 1: Check if a Monthly Attendance record exists for the current employee and the current month
//             Monthly_Attendance__c monthlyAttendance = getMonthlyAttendance(employee.Id, currentMonth, currentYear);
    
//             if (monthlyAttendance == null) {
//                 // Step 2: If no Monthly Attendance record exists, create one
//                 monthlyAttendance = new Monthly_Attendance__c();
//                 monthlyAttendance.Employee__c = employee.Id; // Use the employee ID
//                 monthlyAttendance.Month__c = currentMonth; // No need for String conversion
//                 monthlyAttendance.Year__c = currentYear; // No need for String conversion
//                 monthlyAttendance.Start_date__c = Date.today().toStartOfMonth();
//                 monthlyAttendance.End_date__c = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
    
              
//                 try {
//                     insert monthlyAttendance; // Insert the new Monthly Attendance record
//                 } catch (DmlException e) {
//                     System.debug('Error inserting Monthly Attendance: ' + e.getMessage());
//                     return null; // Return null if insert fails
//                 }
//             }
    
//             // Step 3: Create the Attendance record related to the Monthly Attendance
//             Attendance__c attendance = new Attendance__c();
//             attendance.Monthly_Attendance__c = monthlyAttendance.Id; 
//             attendance.Punch_in__c = currentDTime;
//             attendance.Employee__c = employee.Id; 
    
//             try {
//                 insert attendance; // Insert the new Attendance record
//             } catch (DmlException e) {
//                 System.debug('Error inserting Attendance: ' + e.getMessage());
//                 return null; // Return null if insert fails
//             }
    
//             return currentDTime; // Return the current date and time on successful insert
//         }
//         @AuraEnabled
//         public static DateTime updatePunchOutRecord() {
//             String loggedInUserName = UserInfo.getName();
//             Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE Name__c = :loggedInUserName LIMIT 1];
//             if (employee == null) {
//                 System.debug('Employee not found for the current user.');
//                 return null; // Return null if no employee found
//             }
//             DateTime currentDTime = DateTime.now();
//                 Integer currentMonth = currentDTime.month();
//                 Integer currentYear = currentDTime.year();

//             Attendance__c attendance = getAttendance(employee.Id);

//             if(attendance ==null) { 
                
//                 // Step 1: Check if a Monthly Attendance record exists for the current employee and the current month
//                 Monthly_Attendance__c monthlyAttendance = getMonthlyAttendance(employee.Id, currentMonth, currentYear);
        
//                 if (monthlyAttendance == null) {
//                     // Step 2: If no Monthly Attendance record exists, create one
//                     monthlyAttendance = new Monthly_Attendance__c();
//                     monthlyAttendance.Employee__c = employee.Id; // Use the employee ID
//                     monthlyAttendance.Month__c = currentMonth; // No need for String conversion
//                     monthlyAttendance.Year__c = currentYear; // No need for String conversion
//                     monthlyAttendance.Start_date__c = Date.today().toStartOfMonth();
//                     monthlyAttendance.End_date__c = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
        
//                     try {
//                         insert monthlyAttendance; // Insert the new Monthly Attendance record
//                     } catch (DmlException e) {
//                         System.debug('Error inserting Monthly Attendance: ' + e.getMessage());
//                         return null; // Return null if insert fails
//                     }
//                 }
        
//                 // Step 3: Create the Attendance record related to the Monthly Attendance
//                  attendance = new Attendance__c();
//                 attendance.Monthly_Attendance__c = monthlyAttendance.Id; 
//                 attendance.Punch_in__c = currentDTime;
//                 attendance.punch_out__c = currentDTime;
//                 attendance.Employee__c = employee.Id; 
        
//                 try {
//                     insert attendance; // Insert the new Attendance record
//                 } catch (DmlException e) {
//                     System.debug('Error inserting Attendance: ' + e.getMessage());
//                     return null; // Return null if insert fails
//                 }
        
//                 return currentDTime; // Return the current date and time on successful insert
                
//             }
//             else{
//                 attendance.Punch_Out__c = currentDTime;
                
//                 try {
//                     update attendance; // Insert the new Attendance record
//                 } catch (DmlException e) {
//                     System.debug('Error inserting Attendance: ' + e.getMessage());
//                     return null; // Return null if insert fails
//                 }

//             }

//             return currentDTime;

//         }

//         // Method to retrieve Monthly Attendance record for the current employee and month
//         private static Monthly_Attendance__c getMonthlyAttendance(Id employeeId, Integer month, Integer year) {
//             List<Monthly_Attendance__c> records = [SELECT Id FROM Monthly_Attendance__c 
//                                                    WHERE Employee__c = :employeeId
//                                                    AND Month__c = :month
//                                                    AND Year__c = :year 
//                                                    LIMIT 1];
//             return records.isEmpty() ? null : records[0];
//         }


//        private static  Attendance__c getAttendance(Id employeeId) {

//         DateTime startOfDay = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0)); // Start of the day (00:00:00)
//             DateTime endOfDay = DateTime.newInstance(Date.today(), Time.newInstance(23, 59, 59, 999));
//          List<Attendance__c> records =[SELECT Id From Attendance__c
//                                       WHERE Employee__c =:employeeId
//                                        AND CreatedDate >= :startOfDay 
//                                        AND CreatedDate <= :endOfDay 
//                                        LIMIT 1];
                                        
//            return records.isEmpty() ? null : records[0];
//         }
       
    
// }  




public without sharing class AttendenceController {
    
    @AuraEnabled
    public static Map<String, DateTime> getAttendanceTimes() {
        Map<String, DateTime> attendanceTimes = new Map<String, DateTime>();

        String loggedInUserName = UserInfo.getName();
        Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE Name__c = :loggedInUserName LIMIT 1];

        if (employee == null) {
            System.debug('Employee not found for the current user.');
            return null; 
        }

        DateTime startOfDay = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0)); 
        DateTime endOfDay = DateTime.newInstance(Date.today(), Time.newInstance(23, 59, 59, 999)); 

        List<Attendance__c> existingAttendance = [SELECT Id, Punch_in__c, Punch_Out__c 
                                                  FROM Attendance__c 
                                                  WHERE Employee__c = :employee.Id 
                                                  AND Punch_in__c >= :startOfDay 
                                                  AND Punch_in__c <= :endOfDay 
                                                  LIMIT 1];
        
        if (!existingAttendance.isEmpty()) {
            attendanceTimes.put('PunchIn', existingAttendance[0].Punch_in__c);
            attendanceTimes.put('PunchOut', existingAttendance[0].Punch_Out__c);
        }

    

        return attendanceTimes;
    }


    @AuraEnabled 

    public static DateTime createOrUpdateAttendance(Boolean isPunchOut,Boolean isWfh) {
        String loggedInUserName = UserInfo.getName();
        Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE Name__c = :loggedInUserName LIMIT 1];
    
        if (employee == null) {
            System.debug('Employee not found for the current user.');
            return null;
        }

        DateTime currentDTime = DateTime.now();
    
        Attendance__c attendance = getAttendance(employee.Id);
        System.debug('isPunchOut' + isPunchOut);
        System.debug('attendance' + attendance); 

        if (attendance == null) {
            
            Monthly_Attendance__c monthlyAttendance = getMonthlyAttendance(employee.Id, currentDTime.month(), currentDTime.year());

            if (monthlyAttendance == null) {
              Date  startDate = Date.today().toStartOfMonth();
              Date  endDate = Date.today().toStartOfMonth().addMonths(1).addDays(-1);

              Integer holidaysCount = [SELECT COUNT() FROM Holiday_yearwise__c
                                             WHERE Date__c >= :startDate 
                                             AND Date__c <= :endDate 
                                             AND (DAY_IN_WEEK(Date__c) != 7 
                                             AND DAY_IN_WEEK(Date__c) != 6)];
                monthlyAttendance = new Monthly_Attendance__c(Employee__c = employee.Id, Month__c = currentDTime.month(), Year__c = currentDTime.year(), 
                                                              Start_date__c = startDate, 
                                                              End_date__c =  endDate,
                                                              Total_Holidays__c = holidaysCount );
                insert monthlyAttendance;
            }

            attendance = new Attendance__c(Employee__c = employee.Id, Monthly_Attendance__c = monthlyAttendance.Id, Punch_in__c = currentDTime);
           if(isWfh){
            attendance.WFH__c = true;
           }
        insert attendance;
    
            
     } else if (isPunchOut) {
            attendance.Punch_Out__c = currentDTime;
            update attendance;
        
    }
         
            
    System.debug('currentDTime-->'+currentDTime);
        return currentDTime;
}

    private static Attendance__c getAttendance(Id employeeId) {
        DateTime startOfDay = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
        DateTime endOfDay = DateTime.newInstance(Date.today(), Time.newInstance(23, 59, 59, 999));
        List<Attendance__c> records = [SELECT Id, Punch_in__c, Punch_Out__c FROM Attendance__c 
                                       WHERE Employee__c = :employeeId 
                                       AND Punch_in__c >= :startOfDay 
                                       AND Punch_in__c <= :endOfDay 
                                       LIMIT 1];
        return records.isEmpty() ? null : records[0];
    }

    private static Monthly_Attendance__c getMonthlyAttendance(Id employeeId, Integer month, Integer year) {
        List<Monthly_Attendance__c> records = [SELECT Id FROM Monthly_Attendance__c 
                                               WHERE Employee__c = :employeeId 
                                               AND Month__c = :month 
                                               AND Year__c = :year 
                                               LIMIT 1];
        return records.isEmpty() ? null : records[0];
    }
}