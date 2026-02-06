using {Sales as service} from '../service';

annotate service.Countries with {
    code @title : 'Countries'
         @Common: {
        Text           : name,
        TextArrangement: #TextOnly
    }
};