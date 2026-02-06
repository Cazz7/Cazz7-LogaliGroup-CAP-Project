using {Sales as service} from '../service';

using from './annotations-countries';
using from './annotations-orderstatus';
using from './annotations-salesitems';

annotate service.SalesHeader with @odata.draft.enabled;

annotate service.SalesHeader with {
    email        @title: 'Email';
    firstname    @title: 'First Name';
    lastname     @title: 'Last Name';
    country      @title: 'Country';
    createdOn    @title: 'Created On';
    deliveryDate @title: 'Delivery Date';
    status  @title: 'Order Status';
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
                LocalDataProperty : country.code,
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
        TypeNamePlural: 'Sales',
        //Object page
        Title : {
            $Type : 'UI.DataField',
            Value : firstname
        },
        Description : {
            $Type : 'UI.DataField',
            Value : createdOn 
        }
    },
    //The field group to display details of each Sales Header
    // It does not display by itself}. It needs a container
    // We need another field group for an extra column of fields
    // For this purpose a Qualifier (#HeaderCol1) is necessary
    UI.FieldGroup #HeaderCol1 : {
        $Type : 'UI.FieldGroupType',
        //Fields to be grouped
        Data : [
            {
                @Type : 'UI.DataField',
                Value : email
            },
            {
                @Type : 'UI.DataField',
                Value : country
            },
            {
                @Type : 'UI.DataField',
                Value : orderStatus.descr
            }
        ]
    },
    UI.FieldGroup #HeaderCol2 : {
        $Type : 'UI.FieldGroupType',
        //Fields to be grouped
        Data : [
            {
                @Type : 'UI.DataField',
                Value : firstname
            },
            {
                @Type : 'UI.DataField',
                Value : lastname
            },
            {
                @Type : 'UI.DataField',
                Value : createdOn
            }
        ]
    },
    //Container[
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#HeaderCol1',
            Label : ''
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#HeaderCol2',
            Label : ''
        }
    ],

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
            Value: country.code
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
            Value      : status.code,
            Criticality: status.criticality
        }
    ]
);
