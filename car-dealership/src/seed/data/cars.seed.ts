import { Car } from "src/cars/interfaces/cars.interface";
import { v4 as uuid, v4 } from "uuid";

export const CARS_SEED:Car[] = [
    {
        id:uuid(),
        brand:'Toyota',
        model:'Corolla',
    },
    {
        id:uuid(),
        brand:'Honda',
        model:'Civic',
    },
    {
        id:uuid(),
        brand:'Jeep',
        model:'Wrangler',
    }
];