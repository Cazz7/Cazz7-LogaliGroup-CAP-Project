using {Sales as service} from '../service';

using from './annotations-countries';
using from './annotations-orderstatus';
using from './annotations-salesitems';

annotate service.SalesHeader with @odata.draft.enabled;

annotate service.SalesHeader with {
    salesID      @title: 'Sales ID' @Common.FieldControl: #ReadOnly;
    email        @title: 'Email';
    firstname    @title: 'First Name';
    lastname     @title: 'Last Name';
    country      @title: 'Country';
    createdOn    @title: 'Created On'  @Common.FieldControl: #ReadOnly;
    deliveryDate @title: 'Delivery Date';
    status       @title: 'Order Status';
    image        @title: 'Image';
};

//Print text only
annotate service.SalesHeader with {
    country @Common: {
        Text           : country.name,
        TextArrangement: #TextOnly,
        // To modify the value help fields
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Countries',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: country.code,
                ValueListProperty: 'code',
            }, ]
        },
    }
}

annotate service.SalesHeader with @(
    //Filters
    UI.SelectionFields        : [
        orderStatus_code,
        deliveryDate,
        country_code
    ],
    //Header
    UI.HeaderInfo             : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Sale',
        TypeNamePlural: 'Sales',
        //Object page (New entry)
        Title         : {
            $Type: 'UI.DataField',
            Value: salesID
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: firstname
        }
    },
    //The field group to display details of each Sales Header
    // It does not display by itself}. It needs a container
    // We need another field group for an extra column of fields
    // For this purpose a Qualifier (#HeaderCol1) is necessary
    UI.FieldGroup #Image      : {
        $Type: 'UI.FieldGroupType',
        //Fields to be grouped
        Data : [{
            @Type: 'UI.DataField',
            Value: image,
            Label: ''
        }]
    },
    UI.FieldGroup #HeaderCol1 : {
        $Type: 'UI.FieldGroupType',
        //Fields to be grouped
        Data : [
            {
                @Type: 'UI.DataField',
                Value: lastname
            },
            {
                @Type: 'UI.DataField',
                Value: email
            },
            {
                @Type: 'UI.DataField',
                Value: country_code
            }
        ]
    },
    UI.FieldGroup #HeaderCol2 : {
        $Type: 'UI.FieldGroupType',
        //Fields to be grouped
        Data : [

            {
                @Type: 'UI.DataField',
                Value: createdOn
            },
            {
                @Type: 'UI.DataField',
                Value: deliveryDate
            },
            {
                @Type: 'UI.DataField',
                Value: status.descr
            }
        ]
    },
    UI.FieldGroup #OrderStatus: {
        $Type: 'UI.FieldGroupType',
        Data : [

        {
            $Type               : 'UI.DataField',
            Value               : status_code,
            Criticality         : status.criticality,
            Label               : '',
            @Common.FieldControl: {$edmJson: {$If: [
                {$Eq: [
                    {$Path: 'IsActiveEntity'},
                    false
                ]},
                1,
                3
            ]}}
        }]
    },
    //Container[
    UI.HeaderFacets           : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Image',
            Label : 'Image'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#HeaderCol1',
            Label : 'General Info'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#HeaderCol2',
            Label : 'Name '
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#OrderStatus',
            Label : 'Status'
        }
    ],

    // Including columns
    UI.LineItem               : [
        {
            $Type: 'UI.DataField',
            Value: salesID
        },
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
            Value      : status.name,
            Criticality: status.criticality
        },
        {
            $Type: 'UI.DataField',
            Value: image
        }
    ],
    UI.Facets                 : [

    {
        $Type : 'UI.ReferenceFacet',
        Target: 'toItems/@UI.LineItem',
        Label : 'Sales Item',
        ID    : 'toItems'
    }]
);
// Voy en video 14. Minuto 49
