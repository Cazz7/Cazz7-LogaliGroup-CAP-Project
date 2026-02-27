using {Sales as service} from '../service';

annotate service.VH_Status with {
    code @title: '{i18n>status}'
         @Common: {
        Text           : name,
        TextArrangement: #TextOnly
    }
};