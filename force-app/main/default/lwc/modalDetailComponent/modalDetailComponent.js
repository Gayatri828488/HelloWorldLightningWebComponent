import { LightningElement, track, api } from 'lwc';

export default class ModalDetailComponent extends LightningElement {
   @track isModalVisible  = false;
   @track holidayType;
   @track startDate;
    @track endDate ;


    @api showModal(holidayDetails) {
     
    const  holidaysDetails  = JSON.stringify(holidayDetails);
    
    this.holidayType = holidayDetails.title;
   
    this.startDate = holidayDetails.start.toLocaleDateString();
   
    this.endDate =  holidayDetails.end.toLocaleDateString() ;
   
    this.isModalVisible = true;
    }

// Method to close the modal
   closeModal() {
    this.isModalVisible = false;
    }

}