/*
*********************************************************
Apex Class Name    : AttendenceController.cls        
 Author : gayatri Lakhwani                                            
*********************************************************
*/
public without sharing class AttendenceController {
    /*
***************************************************************************
@Method Name    : getAttendanceTimes
@description    : method to is used to fetch punch_in and punch_out time 
*************************************************************************
*/
    @AuraEnabled
    public static Map<String, DateTime> getAttendanceTimes() {
        Map<String, DateTime> attendanceTimes = new Map<String, DateTime>();

        String loggedInUserId = UserInfo.getuserId();
       
 Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE User__c = :loggedInUserId LIMIT 1];
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


    
        /*
***************************************************************************
@Method Name    : getAttendanceTimes
@description    : method to is used to create or update Attendance record 
*************************************************************************
*/
    @AuraEnabled 

    public static DateTime createOrUpdateAttendance(Boolean isPunchOut,Boolean isWfh) {
        String loggedInUserId = UserInfo.getuserId();
       
        Employee__c employee = [SELECT Id, Name__c FROM Employee__c WHERE User__c = :loggedInUserId LIMIT 1];
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

              Integer weekendCount = 0;
                for (Date currentDate = startDate; currentDate <= endDate; currentDate = currentDate.addDays(1)) {
                    Integer dayOfWeek = currentDate.day();
                     
                    if (dayOfWeek == 1 || dayOfWeek == 7) { 
                        weekendCount++;
                    }
                }


              
              Integer holidaysCount = [SELECT COUNT() FROM Holiday_yearwise__c
                                             WHERE Date__c >= :startDate 
                                             AND Date__c <= :endDate 
                                             AND (DAY_IN_WEEK(Date__c) != 1 
                                             AND DAY_IN_WEEK(Date__c) != 7)];


                monthlyAttendance = new Monthly_Attendance__c(Employee__c = employee.Id, Month__c = currentDTime.month(), Year__c = currentDTime.year(), 
                                                              Start_date__c = startDate, 
                                                              End_date__c =  endDate,
                                                              Total_Holidays__c = holidaysCount ,
                                                              TotalWeekend__c  =  weekendCount*2
                                                              );
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

    /*
***************************************************************************
@Method Name    : getAttendance
@description    : method to is used to  query  todays Attedence record
*************************************************************************
*/
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

        /*
***************************************************************************
@Method Name    : getMonthlyAttendance
@description    : method to is used to fetch monthly record of current month
*************************************************************************
*/
    private static Monthly_Attendance__c getMonthlyAttendance(Id employeeId, Integer month, Integer year) {
        List<Monthly_Attendance__c> records = [SELECT Id FROM Monthly_Attendance__c 
                                               WHERE Employee__c = :employeeId 
                                               AND Month__c = :month 
                                               AND Year__c = :year 
                                               LIMIT 1];
        return records.isEmpty() ? null : records[0];
    }
}


