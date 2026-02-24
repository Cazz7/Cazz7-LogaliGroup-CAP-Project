const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

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
            //req.data.createdOn = 'LowAvailability'

            const today = new Date();
            // Delivery date 3 days in the future by default
            const futureDate = new Date();
            futureDate.setDate(futureDate.getDate() + 3);
            // Get current date in YYYY-MM-DD format
            const currentDate = today.toISOString().split('T')[0];
            const deliveryDate = futureDate.toISOString().split('T')[0];
            //const deliveryDate = today.toISOString().split('T')[0];

            req.data.createdOn = currentDate;
            req.data.deliveryDate = deliveryDate;
            console.log({ data: req.data });
            req.data.status_code = 'New';
        });

        this.before('NEW', SalesHeader.drafts, async (req) => {
            let dbp = await SELECT.one.from(SalesHeader).columns('max(salesID)');
            let dbd = await SELECT.one.from(SalesHeader.drafts).columns('max(salesID)');

            let maxp = parseInt(dbp.max);
            console.log({"maxp" : maxp});

            let maxd = parseInt(dbd.max);
            console.log({"maxd" : maxd});

            
            let newMax = 0;
            
            if (isNaN(maxd)) {
                newMax = maxp + 1; //10000000360 --> 10000000361
            } else if (maxp < maxd) {
                newMax = maxd + 1; //10000000361 --> 10000000362
            } else if (isNaN(maxp) && !isNaN(maxd)) {
                newMax = maxd + 1; //10000000361 --> 10000000362
            } else {
                newMax = maxp + 1;
            }
            console.log(newMax);

            //initialization
            if (isNaN(maxd) && isNaN(maxp)) newMax = 50000000;
            console.log(newMax);

            req.data.salesID = newMax.toString();
        });

        return super.init();
    }

}