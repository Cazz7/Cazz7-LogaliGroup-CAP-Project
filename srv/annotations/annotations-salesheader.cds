using {Sales as service} from '../service';

using from './annotations-countries';

annotate service.SalesHeader with @odata.draft.enabled;

annotate service.SalesHeader with {
    email        @title: 'Email';
    firstname    @title: 'First Name';
    lastname     @title: 'Last Name';
    country      @title: 'Country';
    createdOn    @title: 'Created On';
    deliveryDate @title: 'Delivery Date';
    orderStatus  @title: 'Order Status';
//imageURL        @title: 'Image URL';
};

//Print text only
annotate service.SalesHeader with {
    country @Common: {
        Text           : country.name,
        TextArrangement: #TextOnly,
        // To modify the value help fields
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Countries',
            Parameters : [{
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : country_code,
                ValueListProperty : 'code',
            },]
        },
    }
}

annotate service.SalesHeader with @(
    //Filters
    UI.SelectionFields: [
        orderStatus_code,
        deliveryDate,
        country_code
    ],
    //Header
    UI.HeaderInfo     : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Sale',
        TypeNamePlural: 'Sales'
    },
    // Including columns
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: email
        },
        {
            $Type: 'UI.DataField',
            Value: firstname
        },
        {
            $Type: 'UI.DataField',
            Value: lastname
        },
        {
            $Type: 'UI.DataField',
            Value: country
        },
        {
            $Type: 'UI.DataField',
            Value: createdOn
        },
        {
            $Type: 'UI.DataField',
            Value: deliveryDate
        },
        {
            $Type      : 'UI.DataField',
            Value      : orderStatus.name,
            Criticality: orderStatus.criticality
        }
    ]
);
