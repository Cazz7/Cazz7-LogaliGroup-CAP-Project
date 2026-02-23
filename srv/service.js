const cds = require('@sap/cds');

module.exports = class Sales extends cds.ApplicationService {

    init() {

        const { SalesHeader } = this.entities;

        //CREATE --> New in draft
        //UPDATE
        //DELETE
        //READ

        //before, on after

        //on is for action
        //after is for validations

        this.before('NEW', SalesHeader.drafts, async (req) => {
            req.data.createdOn = 'LowAvailability'

            const today = new Date();
            // Delivery date 3 days in the future by default
            const futureDate = new Date();
            futureDate.setDate(futureDate.getDate() + 3);
            // Get current date in YYYY-MM-DD format
            const currentDate = today.toISOString().split('T')[0];
            //const deliveryDate = futureDate.toISOString().split('T')[0];
            const deliveryDate = today.toISOString().split('T')[0];

            req.data.createdOn = currentDate;
            req.data.deliveryDate = deliveryDate;
            console.log( { data : req.data } );
            req.data.status_code = 'InStock';
        });

        return super.init();
    }

}