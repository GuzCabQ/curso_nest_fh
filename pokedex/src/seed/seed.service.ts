import { InsertPokemon } from './../pokemon/interfaces/pokemon.interface';
import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { catchError, firstValueFrom } from 'rxjs';
import { PokeResponse } from './interfaces/poke-response.interface';
import { PokemonService } from 'src/pokemon/pokemon.service';
import { AxiosError } from 'axios';
import { AxiosAdapter } from 'src/common/adapters/axios.adaprter';

@Injectable()
export class SeedService {
  private readonly axios: HttpService = new HttpService();
  constructor(
    private readonly http: AxiosAdapter,
    private readonly pokemonService: PokemonService,
  ) { }
  async executeSeed() {

    await this.pokemonService.deleteAll();

    // const insertPromisesArray = [];
    const pokemonToInsert: InsertPokemon[] = [];
    
    const data = await this.http.get<PokeResponse>('https://pokeapi.co/api/v2/pokemon?limit=650');

    data.results.forEach(({ name, url }) => {
      const segments = url.split('/');
      const no: number = +segments[segments.length - 2];
      // insertPromisesArray.push(this.pokemonService.create({ name, no }));
      pokemonToInsert.push({ name, no });
      // this.pokemonService.create({ name, no });
    });

    // await Promise.all(insertPromisesArray);
    await this.pokemonService.insertMany(pokemonToInsert);
    return 'Seed executed';
  }
}

// No se uso axios directamente, se uso: npm i --save @nestjs/axios axios
// Revisar video 94, Resolución - Insertar pokemons por lote
// Se solucióno la tarea de otra forma