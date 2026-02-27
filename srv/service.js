const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = class Sales extends cds.ApplicationService {

    init() {

        const { SalesHeader, SalesItems } = this.entities;

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

        /*this.before('NEW', SalesHeader.drafts, async (req) => {
            let dbp = await SELECT.one.from(SalesHeader).columns('max(salesID)');
            let dbd = await SELECT.one.from(SalesHeader.drafts).columns('max(salesID)');

            console.log("dbd", dbd);

            let maxp = parseInt(dbp.max);

            let maxd = parseInt(dbd.max);


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
        });*/


this.before('NEW', SalesHeader.drafts, async (req) => {
  // Read max from ACTIVE
  const rowsActive = await SELECT
    .from(SalesHeader)
    .columns`max(salesID) as maxActive`;

  // Read max from DRAFTS
  const rowsDraft  = await SELECT
    .from(SalesHeader.drafts)
    .columns`max(salesID) as maxDraft`;

  // Coerce to numbers; null/undefined -> 0
  const maxActive = Number(rowsActive?.[0]?.maxActive ?? 0);
  const maxDraft  = Number(rowsDraft ?.[0]?.maxDraft  ?? 0);

  // Guard against NaN (e.g., if salesID is a string type)
  const safeActive = Number.isFinite(maxActive) ? maxActive : 0;
  const safeDraft  = Number.isFinite(maxDraft)  ? maxDraft  : 0;

  // If both are 0, initialize with your seed; otherwise next = max + 1
  const seed = 50000000;
  const base = Math.max(safeActive, safeDraft);
  const next = base === 0 ? seed : base + 1;

  req.data.salesID = String(next); // cast to string if your CDS field is String
});


        /*this.before('NEW', SalesItems.drafts, async (req) => {

            let newMax = 0;

            const salesHeader_ID = req.data.header_ID; // 'header_ID' es el nombre generado por la asociación
            console.log({ "salesHeader_ID": salesHeader_ID });
            //console.log({ "SalesItems": SalesItems });
            if (salesHeader_ID) {

                const highestItemTextP = await SELECT.one.from(SalesItems.drafts).columns('max(itemID) as maxID');


                let dbp = await SELECT.one.from(SalesItems.drafts).columns('max(itemID)');
                //let dbp2 = await SELECT.one.from(Sales.SalesItems.drafts).columns('max(itemID)');

                console.log("highestItemTextP", highestItemTextP);

                //let dbd = await SELECT.one.from(SalesItems.drafts).where({ header_ID: salesHeader_ID }).columns('max(itemID)');

                console.log("dbp", dbp);
                //console.log("dbp2", dbp2);
                /*console.log({ "highestItemTextP": highestItemTextP });
            
                                const highestItemTextP2 = cds.read(SalesItems.drafts)
                                .where({ header_ID: salesHeader_ID })
                                .columns('itemID');
            
                console.log("Resultado de la BD 2:", highestItemTextP2);
            
                            const highestItemTextD = await SELECT.one.from(SalesItems.drafts)
                                .where({ header_ID: salesHeader_ID }) // 'header_ID' es el nombre generado para la asociación
                                .orderBy('itemID desc')
                                .columns('itemID');
            
            console.log({ "highestItemTextP": highestItemTextP });
            console.log({ "highestItemTextD": highestItemTextD });
            
                            const highestItemP = parseInt(highestItemTextP);
                            const highestItemD = parseInt(highestItemTextD);
            
            console.log({ "highestItemP": highestItemP });
            console.log({ "highestItemD": highestItemD });
            
                            if (isNaN(highestItemD)) {
                                newMax = highestItemP + 1;
                            } else if (highestItemP < highestItemD) {
                                newMax = maxd + 1;
                            } else if (isNaN(highestItemP) && !isNaN(highestItemD)) {
                                newMax = highestItemD + 1;
                            } else {
                                newMax = highestItemP + 1;
                            }
                            console.log(newMax);
            
                            /*if (isNaN(highestItem)) {
                                newMax = 1;
                            } else {
                                newMax = highestItem + 1.
                            }

                //req.data.itemID = newMax.toString();
            }
        });*/

        
this.before('NEW', SalesItems.drafts, async (req) => {
  const header_ID = req.data.header_ID; // FK to the header
  if (!header_ID) return; // Nothing to do if we don't know the parent yet

  // Read the largest itemID among ACTIVE items for this header
  const rowsActive = await SELECT
    .from(SalesItems)
    .columns`max(itemID) as maxActive`
    .where({ header_ID });

  // Read the largest itemID among DRAFT items for this header
  const rowsDraft = await SELECT
    .from(SalesItems.drafts)
    .columns`max(itemID) as maxDraft`
    .where({ header_ID });

  // Rows may be empty or max* may be null → coalesce to 0
  const maxActive = Number(rowsActive?.[0]?.maxActive ?? 0);
  const maxDraft  = Number(rowsDraft?.[0]?.maxDraft  ?? 0);

  const next = Math.max(
    Number.isFinite(maxActive) ? maxActive : 0,
    Number.isFinite(maxDraft)  ? maxDraft  : 0
  ) + 1;

  req.data.itemID = String(next); // keep as string if your CDS type is String
});


        return super.init();
    }

}