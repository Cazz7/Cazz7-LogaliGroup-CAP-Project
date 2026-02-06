using {Sales as service} from '../service';

annotate service.VH_Status with {
    code @title : 'Status'
         @Common: {
        Text           : code,
        TextArrangement: #TextOnly
    }
};