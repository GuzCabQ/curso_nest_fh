import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { firstValueFrom } from 'rxjs';
import { PokeResponse } from './interfaces/poke-response.interface';

@Injectable()
export class SeedService {
  constructor(private readonly axios: HttpService) { }
  async executeSeed() {
    const { data } = await firstValueFrom(this.axios.get<PokeResponse>('https://pokeapi.co/api/v2/pokemon?limit=10'));
    data.results.forEach(({ name, url }) => {
      const segments = url.split('/');
      const no:number=+segments[segments.length-2];
      console.log({name,no});
    });
    return data.results;
    // return 'Seed executed';
  }
}
