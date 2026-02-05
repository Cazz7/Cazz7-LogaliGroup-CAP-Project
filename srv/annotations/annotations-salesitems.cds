using {Sales as service} from '../service';

annotate service.SalesItems with {
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
    unitOfMeasure    @title: 'Unit of Measure'  @Common.FieldControl : #ReadOnly;
//imageURL        @title: 'Image URL';
};

annotate service.SalesHeader with @(UI.LineItem: [
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
    },
    {
        $Type: 'UI.DataField',
        Value: unitOfMeasure
    }
]);
