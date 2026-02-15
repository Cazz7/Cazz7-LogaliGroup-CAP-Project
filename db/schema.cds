namespace com.salesorder;

using {
    cuid,
    managed,
    sap.common.Currencies,
    sap.common.Countries,
    sap.common.CodeList
} from '@sap/cds/common';

entity SalesHeader : cuid, managed {

    email        : String(40);
    firstname    : String(40);
    lastname     : String(40);
    country      : Association to Countries;
    createdOn    : Date;
    deliveryDate : Date;
    status  : Association to OrderStatus;
    imageURL     : String(10);//LargeBinary  @Core.MediaType: imageType  @UI.IsImage;
    toItems      : Composition of many SalesItems
                       on toItems.header = $self
}

type volume : Decimal(15, 3);

entity SalesItems : cuid {

    name             : String(40);
    description      : String(40);
    releasedDate     : Date;
    discontinuedDate : Date;
    price            : Decimal(12, 2);
    currency         : Association to Currencies; //currency_code
    height           : volume;
    width            : volume;
    depth            : volume;
    quantity         : Decimal(16, 2);
    unitOfMeasure    : String default 'CM';
    header           : Association to SalesHeader;

}

/*entity OrderStatus : CodeList {
    key code        : String enum {
            New = 'New';
            Accepted = 'Accepted';
            Cancelled = 'Cancelled';
        }
        criticality : Int16; // 1,2,3,5
};*/

entity OrderStatus : CodeList {
    key code        : String enum {
            InStock = 'In Stock';
            OutOfStock = 'Out of Stock';
            LowAvailability = 'Low Availability';
        }
        criticality : Int16; // 1,2,3,5
};