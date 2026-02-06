using { com.salesorder as entities } from '../db/schema';

// Here we create the projections
service Sales {

    entity SalesHeader as projection on entities.SalesHeader;
    entity SalesItems as projection on entities.SalesItems;

    //value helps
    @readonly
    entity VH_Status as projection on entities.OrderStatus;
}