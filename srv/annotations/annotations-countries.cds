using {Sales as service} from '../service';

annotate service.Countries with {
    code @title : '{i18n>country}'
         @Common: {
        Text           : name,
        TextArrangement: #TextOnly
    }
};