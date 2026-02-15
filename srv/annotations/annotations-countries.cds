using {Sales as service} from '../service';

annotate service.Countries with {
    code @title : 'Country'
         @Common: {
        Text           : name,
        TextArrangement: #TextOnly
    }
};