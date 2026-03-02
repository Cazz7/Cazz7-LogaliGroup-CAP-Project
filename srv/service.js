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

            req.data.createdOn = currentDate;
            req.data.deliveryDate = deliveryDate;
            console.log({ data: req.data });
            req.data.status_code = 'New';
        });

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