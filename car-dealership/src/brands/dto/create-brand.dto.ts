import { IsString, Min, MinLength } from 'class-validator';
import { name } from './../../../node_modules/ci-info/index.d';
export class CreateBrandDto {

    @IsString()
    @MinLength(3)
    name: string;
}
