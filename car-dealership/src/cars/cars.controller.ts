import { Body, Controller, Delete, Get, NotFoundException, Param, ParseIntPipe, ParseUUIDPipe, Patch, Post, UsePipes, ValidationPipe } from '@nestjs/common';
import { CarsService } from './cars.service';
import { CreateCarDto } from './dto/create-car.dto';
import { UpdateCarDto } from './dto/update-car.dto';

@Controller('cars')
export class CarsController {

    constructor(private readonly carsService: CarsService) { }

    @Get()
    getAllCars() {
        return this.carsService.findAll();
    }

    @Get(':id')
    getCarById(@Param('id', new ParseUUIDPipe({version:'4'})) id: string) {
        const car = this.carsService.findOneById(id);
        if (!car) throw new NotFoundException(`Car with id ${id} not found`);
        return car;
    }

    @Post()
    createCar(@Body() createCarDto: CreateCarDto){
        return this.carsService.createCar(createCarDto);
    }

    @Patch(':id')
    updateCar(
        @Param('id', new ParseUUIDPipe({version:'4'})) id: string,
        @Body() updateCarDto: UpdateCarDto){
        return this.carsService.updateCar(id, updateCarDto);
    }

    @Delete(':id')
    deleteCar(@Param('id', new ParseUUIDPipe({version:'4'})) id: string){
        return this.carsService.deleteCar(id);
    }
}
