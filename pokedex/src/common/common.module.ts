import { Module } from '@nestjs/common';
import { AxiosAdapter } from './adapters/axios.adaprter';
import e from 'express';

@Module({
    providers: [AxiosAdapter],
    exports: [AxiosAdapter],
})
export class CommonModule {}
