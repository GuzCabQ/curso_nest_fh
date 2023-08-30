<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

# TESLO API

## Ejecutar en desarrollo

1. Clonar el repositorio
2. Ejecutar

```bash
npm install
```

3. Tener Nest CLI instalado

```bash
npm i -g @nestjs/cli
```

4. Configurar variables de entorno de ```.env.example``` y renombrarlo a ```.env```




5. Levantar la base de datos

```bash
docker-compose up -d
```

6. Reconstruir la base de datos con la semilla

```bash
http://localhost:3000/api/v2/seed
```

## Stack usado

* Postgres
* Nest
