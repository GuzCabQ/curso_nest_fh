import { HttpService } from "@nestjs/axios";
import { HTTPAdapter } from "../interfaces/http-adapter.interface";
import { firstValueFrom } from "rxjs";
import { Injectable } from "@nestjs/common";


@Injectable()
export class AxiosAdapter implements HTTPAdapter {
    private readonly axios: HttpService = new HttpService();
    async get<T>(url: string): Promise<T> {
        try {
            const { data } = await firstValueFrom(this.axios.get<T>('https://pokeapi.co/api/v2/pokemon?limit=650'));
            return data;
        } catch (error) {

            throw new Error(`An error happened pokeApi: ${error.message}`);
        }
    }

}