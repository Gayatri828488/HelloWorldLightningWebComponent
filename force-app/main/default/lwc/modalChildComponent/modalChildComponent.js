import { LightningElement, api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; // Added by Gayatri

import applyHoliday from '@salesforce/apex/ModalChildComponent.applyHoliday';

 
export default class ModalChildComponent extends LightningElement {
    @track holidayType;
    @track startDate;
    @track endDate;
    @track userName;
    @track  isShowModal = false;

    holidayTypeOptions = [
        { label: 'Annual Leave', value: 'Annual Leave' },

        { label: 'Sick Leave', value: 'Sick Leave' },
        { label: 'Casual Leave', value: 'Casual Leave' }
    ];

    @api showModalForm(){
        this.isShowModal = true;
        console.log('this my model fetch value'+ this.isShowModal );
        

      console.log('this is parent function call');
      
   }

    hideUserForm(){
    this.isShowModal = false;

   }
   handleUserNameChanges(event){
 this.userName = event.target.value;
   }
   handleEndDate(event){
    this.endDate = event.target.value;
   }
   
   
    handleStartDate(event){
    this.startDate = event.target.value;
   }

     handleHolidayType(event){
    this.holidayType = event.target.value;
   }
    handleSubmit() {
        const holiday= {
            holidayType  : this.holidayType, 
            startDate : this.startDate,
            endDate : this.endDate,
            name: this.userName
        }

        // Call Apex to create the user  holiday record

    applyHoliday({holidayData: JSON.stringify(holiday)})
    .then(result => {
            this.showToast('Success', 'Holiday record created successfully!', 'success');
        this. hideUserForm();
       
        
    })
    .catch(error => {
        console.log('Error ' , error); // Added by Gayatri
        this.showToast('Error', 'Error creating holiday record: ' + error.body.message, 'error');
    });
} 
//   Method to show toast messages
showToast(title, message, variant) {
    this.dispatchEvent(
        new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        })
    );
}

}