import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { Car } from './interfaces/cars.interface';
import { v4 as uuid } from 'uuid';
import { CreateCarDto, UpdateCarDto } from './dto/dto';




@Injectable()
export class CarsService {
    private cars: Car[] = [
        
    ];

    public findAll() {
        return this.cars;
    }

    public findOneById(id: string) {
        const car = this.cars.find(car => car.id === id);
        if (!car) throw new NotFoundException(`Car with id ${id} not found`);
        return car;
    }

    public createCar(createCarDto: CreateCarDto) {
        const car: Car = {
            id: uuid(),
            ...createCarDto
        }
        this.cars.push(car);
        return car;
    }

    public updateCar(id: string, updateCarDto: UpdateCarDto) {
        let carDB = this.findOneById(id);

        if (updateCarDto.id && updateCarDto.id !== id) throw new BadRequestException(`Car id: ${id} is not valid inside body`);
        this.cars = this.cars.map(car => {
            if (car.id === id) {
                carDB = { ...carDB, ...updateCarDto, id };
                return carDB;
            }
            return car;
        });
        return carDB;
    }

    deleteCar(id: string) {
        this.findOneById(id);
        this.cars = this.cars.filter(car => car.id !== id);
    }
    fillCarsWithSeedData(cars:Car[]) {
        this.cars = cars;
    }
}
