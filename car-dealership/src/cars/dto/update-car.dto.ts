import { IsOptional, IsString, IsUUID, MinLength } from "class-validator";

export class UpdateCarDto {

    @IsString()
    @IsUUID()
    @IsOptional()
    readonly id?: string;

    @IsString({message: 'This is a custom message'})
    @IsOptional()
    readonly brand?: string;

    @IsString()
    @MinLength(3 ,{message: 'Tiene que ter 3 o mas'})
    @IsOptional()
    readonly model?: string;
}