import { InsertPokemon } from './interfaces/pokemon.interface';
import { BadRequestException, Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import { CreatePokemonDto } from './dto/create-pokemon.dto';
import { UpdatePokemonDto } from './dto/update-pokemon.dto';
import { Model, isValidObjectId } from 'mongoose';
import { Pokemon } from './entities/pokemon.entity';
import { InjectModel } from '@nestjs/mongoose';
import { PaginaationDto as PaginationDto } from 'src/common/dto/pagination.dto';

@Injectable()
export class PokemonService {

  constructor(
    @InjectModel(Pokemon.name)
    private readonly pokemonModel: Model<Pokemon>
  ) { }

  async create(createPokemonDto: CreatePokemonDto) {
    createPokemonDto.name = createPokemonDto.name.toLocaleLowerCase();
    try {
      const pokemon = await this.pokemonModel.create(createPokemonDto);
      return pokemon;
    } catch (error) {
      this.handleException(error, 'create');
    }
  }

  findAll(paginationDto:PaginationDto) {
    const {limit=10, offset=0} = paginationDto;
    return this.pokemonModel.find()
    .limit(limit)
    .skip(offset)
    .sort({ name: 1 })
    .select('-__v');
  }

  async findOne(id: string) {
    let pokemon: Pokemon;

    //no
    if (!isNaN(+id)) pokemon = await this.pokemonModel.findOne({ no: id });

    //mongo id
    if (!pokemon && isValidObjectId(id)) pokemon = await this.pokemonModel.findById(id);

    //name  
    if (!pokemon) pokemon = await this.pokemonModel.findOne({ name: id.toLocaleLowerCase() });

    if (!pokemon) throw new NotFoundException(`Pokemon with no, id or name: ${id} not found`);

    return pokemon;
  }

  async update(id: string, updatePokemonDto: UpdatePokemonDto) {
    const pokemon = await this.findOne(id);
    if (updatePokemonDto.name) updatePokemonDto.name = updatePokemonDto.name.toLocaleLowerCase();
    try {
      await pokemon.updateOne(updatePokemonDto, { new: true });
    } catch (error) {
      this.handleException(error, 'update');
    }
    return { ...pokemon.toJSON(), ...updatePokemonDto };
  }

  async remove(id: string) {
    // const pokemon = await this.findOne(id);
    // await pokemon.deleteOne();
    // const result = await this.pokemonModel.findByIdAndDelete(id);
    const { deletedCount } = await this.pokemonModel.deleteOne({ _id: id });
    if (deletedCount === 0) throw new BadRequestException(`Pokemon with id: ${id} not found`);
    return;
  }

  async deleteAll() {
    await this.pokemonModel.deleteMany({});
  }

  async insertMany(pokemons: InsertPokemon[]) {
    await this.pokemonModel.insertMany(pokemons);
  }

  private handleException(error: any, message: string) {
    if (error.code === 11000) {
      throw new BadRequestException(`Pokemon already exists ${JSON.stringify(error.keyValue)}`);
    }
    console.error(error);
    throw new InternalServerErrorException(`Can't ${message} pokemon - Check server logs`);
  }
}

