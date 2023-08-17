import { IsString, MinLength } from "class-validator";

export class CreateCarDto {

    @IsString({message: 'This is a custom message'})
    readonly brand: string;

    @IsString()
    @MinLength(3 ,{message: 'Tiene que ter 3 o mas'})
    readonly model: string;
}