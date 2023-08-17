import { IsNumber, IsOptional, IsPositive, Min } from "class-validator";

export class PaginaationDto{
    @IsOptional()
    @IsPositive()
    @Min(1)
    @IsNumber()
    limit?:number;

    @IsOptional()
    @IsPositive()
    @IsNumber()
    offset?:number;
}