using {Sales as service} from '../service';

annotate service.SalesItems with {
    itemID           @title: 'Item ID'          @Common.FieldControl : #ReadOnly;
    name             @title: 'Name';
    description      @title: 'Description';
    releasedDate     @title: 'Released Date';
    discontinuedDate @title: 'Discontinued Date';
    price            @title: 'Price'            @Measures.ISOCurrency: currency_code;
    currency         @title: 'Currency'         @Common.IsCurrency;
    height           @title: 'Height'           @Measures.Unit       : unitOfMeasure;
    width            @title: 'Width'            @Measures.Unit       : unitOfMeasure;
    depth            @title: 'Depth'            @Measures.Unit       : unitOfMeasure;
    quantity         @title: 'Quantity';
    unitOfMeasure    @title: 'Unit of Measure'  @Common.IsUnit  @Common.FieldControl: #ReadOnly;
};

annotate service.SalesItems with @(
    UI.HeaderInfo           : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>typeNameItem}',
        TypeNamePlural: '{i18n>typeNameItems}',
        Title         : {
            $Type: 'UI.DataField',
            Value: header.salesID
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: header.firstname
        }
    },
    UI.LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: itemID
        },
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Value: description
        },
        {
            $Type: 'UI.DataField',
            Value: releasedDate
        },
        {
            $Type: 'UI.DataField',
            Value: discontinuedDate
        },
        {
            $Type             : 'UI.DataField',
            Value             : price,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem'
            }
        },
        {
            $Type: 'UI.DataField',
            Value: currency
        },
        {
            $Type: 'UI.DataField',
            Value: height
        },
        {
            $Type: 'UI.DataField',
            Value: width
        },
        {
            $Type: 'UI.DataField',
            Value: depth
        },
        {
            $Type: 'UI.DataField',
            Value: quantity
        }
    ],
    UI.FieldGroup #SalesItem: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: itemID
            },
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: description
            },
            {
                $Type: 'UI.DataField',
                Value: releasedDate
            },
            {
                $Type: 'UI.DataField',
                Value: discontinuedDate
            },
            {
                $Type: 'UI.DataField',
                Value: price
            },
            {
                $Type: 'UI.DataField',
                Value: height
            },
            {
                $Type: 'UI.DataField',
                Value: width
            },
            {
                $Type: 'UI.DataField',
                Value: depth
            },
            {
                $Type: 'UI.DataField',
                Value: quantity
            }
        ]
    },
    UI.Facets               : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#SalesItem',
        Label : '{i18n>salesItemsFacetLabel}'
    }]
);
