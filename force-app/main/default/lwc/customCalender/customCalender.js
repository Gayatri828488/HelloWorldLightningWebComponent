import { LightningElement, track, api, wire} from 'lwc';
import FullCalendarJS from '@salesforce/resourceUrl/FullCalendar';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
 import { NavigationMixin } from "lightning/navigation";
import getUsersHolidayData from '@salesforce/apex/CustomCalender.getUserHolidayData';
import id from '@salesforce/user/Id';

export default class CustomCalendar extends NavigationMixin(LightningElement) {
// @track isShowModal = false;
 @track  calendar;
 @track calendarTitle;
    
    openModal() {
        const modal = this.template.querySelector('c-modal-child-component');
        if (modal) {
            // Call the child's 'open' method to show the modal
            modal.showModalForm();
        } else {
            console.error('Modal component not found!');
        }
    }

     handleClose(){
        this.isShowModal = false;
    }
   handleSuccess(){
        alert('you form submit succesfully');
    }


    handleEventClick(event) {
        // Extract the details of the clicked event
        const holidayDetails = {
            id: event.id,
            title: event.title,
            start: event.start,
            end: event.end
        };
        const modal = this.template.querySelector('c-modal-detail-component');
        console.log('this is my modal' + modal);
        modal.showModal(holidayDetails); 
         if (modal) {
      
       console.log('mymodal'); // Pass the event data to the modal 
      } else {
          console.error('Modal component not found!');
     }
    }
    
    

    fetchHolidayData() {
        getUsersHolidayData()
            .then(result => {   
                const eventList = [];
                const colorMap = {}; // To store color for the same dates, different users
                let colorIndex = 0;
                const defaultColor = '#0000FF'; // Default color for all users with different dates
                const colors = ['#33FF57', '#3357FF', '#F33FFF', '#FF33A6', '#33FFA6']; // Colors for same dates but different users
    
                for (let holidayData of result) {
                    const currentDate = new Date();
                    const startDate = holidayData.Start_Date__c;
                    const endDate = holidayData.End_Date__c;
                    const eventKey = `${startDate}-${endDate}`; // Unique key based on start and end dates

                    // Check if another user> already has the same start and end dates
                    if (colorMap[eventKey]) {
                        // Assign a new color from the palette for different users with the same dates
                        const userColorMap = colorMap[eventKey];
                        if (!userColorMap[holidayData.Name]) {
                            // Assign a new color if not already assigned for this user with same dates
                            userColorMap[holidayData.Name] = colors[colorIndex % colors.length];
                            colorIndex++;
                        }
                        holidayData.color = userColorMap[holidayData.Name];
                    } else {
                        // If no one else has these dates, assign the default color
                        colorMap[eventKey] = { [holidayData.Name]: defaultColor };
                        holidayData.color = defaultColor;
                    }
    
                    const event = {
                        id: holidayData.Id,
                        editable: false,
                        allDay: false,
                        start: holidayData.Start_Date__c,
                        end: holidayData.End_Date__c,
                        title: holidayData.Holiday_Type__c,
                        backgroundColor: holidayData.color, // Assign color based on user and date
                        borderColor: holidayData.color, // Same color for the border
                    };
                    eventList.push(event);
                }
    
                this.eventsList = eventList;
    
                // After fetching data, initialize or refresh the calendar
                this.initializeCalendar();
            })
            .catch(error => {
                console.error('Error fetching holiday data:', error);
            });
    }
    
    
    calendarActionsHandler(event) {
        const actionName = event.target.value;
        if(actionName === 'previous') {
            this.calendar.prev();
        } else if(actionName === 'next') {
            this.calendar.next();
        } else if(actionName === 'today') {
            this.calendar.today();
        } 
        this.calendarTitle = this.calendar.view.title;
    }
     connectedCallback() {
        Promise.all([
            loadStyle(this, FullCalendarJS + '/lib/main.css'),
            loadScript(this, FullCalendarJS + '/lib/main.js')
        ])
        .then(() => {
            // this.initializeCalendar();
            this.fetchHolidayData();

        })
        .catch(error => console.log(error))
    }

    initializeCalendar() { 
        const calendarEl = this.template.querySelector('div.fullcalendar');
        
        if (this.calendar) {
            // If the calendar is already initialized, update the events
            this.calendar.removeAllEvents(); // Clear existing events
            this.calendar.addEventSource(this.eventsList); // Add new event data
            
        } else {
            const calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: false,
            initialDate: new Date(),
            showNonCurrentDates: false,
            fixedWeekCount: false,
            allDaySlot: false,
            navLinks: false,  
            events: this.eventsList,
            eventClick: (info) => {
                this.handleEventClick(info.event);  // Handle event click to show modal
            }
        });
       
        calendar.render();
        calendar.setOption('contentHeight', 550);
        this.calendarTitle = calendar.view.title;
        this.calendar = calendar;
        this.calendarTitle = calendar.view.title;
 
}
    }
    

}

