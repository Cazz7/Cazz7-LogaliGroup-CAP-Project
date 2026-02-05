using { Sales as service } from '../service';

annotate service.SalesHeader with @odata.draft.enabled;

annotate service.SalesHeader with {
    email      @title: 'Email';
    firstname  @title: 'First Name';
    lastname  @title: 'Last Name';
    country     @title: 'Country';
    createdOn  @title: 'Created On';
    deliveryDate     @title: 'Delivery Date';
    orderStatus    @title: 'Order Status';
    //imageURL        @title: 'Image URL';
};

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
