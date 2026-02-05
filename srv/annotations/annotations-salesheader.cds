using { Sales as service } from '../service';

annotate service.SalesHeader with @(
    UI.LineItem :[
        {
            $Type : 'UI.DataField',
            Value : email
        },
        {
            $Type : 'UI.DataField',
            Value : firstname
        },
        {
            $Type : 'UI.DataField',
            Value : lastname
        },
        {
            $Type : 'UI.DataField',
            Value : country
        },
        {
            $Type : 'UI.DataField',
            Value : createdOn
        },
        {
            $Type : 'UI.DataField',
            Value : deliveryDate
        },
        {
            $Type : 'UI.DataField',
            Value : orderStatus
        }
    ]
);
