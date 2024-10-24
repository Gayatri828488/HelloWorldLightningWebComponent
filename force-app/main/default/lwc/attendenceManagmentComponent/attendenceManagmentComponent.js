import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createOrUpdateAttendance from '@salesforce/apex/AttendenceController.createOrUpdateAttendance';
import getAttendanceTimes from '@salesforce/apex/AttendenceController.getAttendanceTimes';

export default class AttendanceManagementComponent extends LightningElement {
     @track currentDateTime = new Date().toLocaleDateString();
    @track currentDTime;
    @track punchInTime;
    @track punchOutTime;
    @track totalTime;  
    @track punchInTimeDisplay;
    @track puchOutTimeDisplay;
    @track currentDTimeDisplay
    @track isPunchInDisabled = false; 
    @track isWorkFromHOmeDisabled= false;
    @track isPunchOutDisabled =true;              
    
    connectedCallback() {
        getAttendanceTimes()
            .then(response => {
                if (response.PunchIn) {
                    this.punchInTime = new Date(response.PunchIn);
                    this.punchInTimeDisplay=this.formatTimeInAMPM(new Date(response.PunchIn));
                    this.isPunchInDisabled = true;
                    this.isPunchOutDisabled = false;
                    this.isWorkFromHOmeDisabled = true;
                }
                if (response.PunchOut) {
                    this.punchOutTime = new Date(response.PunchOut);
                    this.puchOutTimeDisplay = this.formatTimeInAMPM(new Date(response.PunchOut));
                    
                    this.isPunchOutDisabled = true;
                    this.isPunchInDisabled = true;
                    this.isWorkFromHOmeDisabled = true;
                }
            })
            .catch(error => {
                this.showErrorToast(error.body.message);
            });

        setInterval(() => {
            this.currentDTimeDisplay = new Date().toLocaleTimeString();
            this.currentDTime = new Date();

            
            this.calculateTotalTime();
        }, 1000);
    }

    handlePunchIn() {
        createOrUpdateAttendance({isPunchOut:false ,isWfh: false})
            .then(response => {
                
                this.punchInTime = new Date(response);
                this.punchInTimeDisplay=this.formatTimeInAMPM(new Date(response));
                this.isPunchInDisabled = true;
                this.isPunchOutDisabled = false;
                this.isWorkFromHOmeDisabled = true;
                this.showSuccessToast('Punch In recorded successfully!');
            })
            .catch(error => {
                this.showErrorToast(error.body.message);
            });
    }

    handlePunchOut() {
        createOrUpdateAttendance({isPunchOut:true ,isWfh: false})
            .then(response => {
                this.punchOutTime = new Date(response);
              this.puchOutTimeDisplay = this.formatTimeInAMPM(new Date(response));
                

                console.log('hello this my test'+this.punchOutTime);
                
                this.isPunchOutDisabled = true;
                this.isPunchInDisabled = true;
                this.isWorkFromHOmeDisabled = true;
                this.showSuccessToast('Punch Out recorded successfully!');
            })
            .catch(error => {
                this.showErrorToast(error.body.message);
            });
    }
    handleWorkFromHome(){
        createOrUpdateAttendance({isPunchOut:false ,isWfh: true})
        .then(response=>{
            this.punchInTime  = new Date(response);
           this.punchInTimeDisplay= this.formatTimeInAMPM(new Date(response));;
            this.isWorkFromHOmeDisabled =true;
            this.isPunchInDisabled =true;
            this.isPunchOutDisabled = true;
            this.showSuccessToast('Punch In recorded successfully!');
        })
        .catch(error => {
            this.showErrorToast(error.body.message);
        });
    }

    formatTimeInAMPM(date) {
        let hours = date.getHours();
        let minutes = date.getMinutes();
        const ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12; 
        minutes = minutes < 10 ? '0' + minutes : minutes; 
        const strTime = hours + ':' + minutes + ' ' + ampm;
        return strTime;
    }


    calculateTotalTime() {
        if (this.punchInTime && this.punchOutTime) {
            let timeDiff = this.punchOutTime - this.punchInTime;
            let totalMinutes = Math.floor(timeDiff / (1000 * 60)); 
            let hours = Math.floor(totalMinutes / 60);
            let minutes = totalMinutes % 60;
            this.totalTime = `${hours} hours and ${minutes} minutes`;
        } else if (this.punchInTime) {
            let timeDiff = new Date() - this.punchInTime;
            let totalMinutes = Math.floor(timeDiff / (1000 * 60)); 
            let hours = Math.floor(totalMinutes / 60);
            let minutes = totalMinutes % 60;
            this.totalTime = `${hours} hours and ${minutes} minutes`;
        } else {
            this.totalTime = "No punch-in time found.";
        }
    }

    showSuccessToast(message) {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: message,
            variant: 'success'
        }));
    }

    showErrorToast(message) {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Error',
            message: message,
            variant: 'error'
        }));
    }

    renderedCallback() {
        if (this.currentDTime) {
            this.calculateTotalTime();
        }
    }
}
