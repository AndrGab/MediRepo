<h1 align="center">
  <img alt="Logo" src="https://user-images.githubusercontent.com/57791712/119592166-52709080-bdae-11eb-8bfe-f9b0a68f4950.png">
</h1>

<h3 align="center">
  Elixir/Phoenix API for Daily Medical Reports
</h3>

<p align="center">Making communication easier for Hospitals and Pacients Family</p>

<p align="center">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/Andrgab/MediRepo?color=ff69b4&logo=elixir">

  <a href="https://www.linkedin.com/in/andrgab/" target="_blank" rel="noopener noreferrer">
    <img alt="Made by" src="https://img.shields.io/badge/made%20by-Andre%20Gabriel-ff69b4?logo=linkedin">
  </a>
  
  <a href="https://codecov.io/gh/AndrGab/MediRepo" target="_blank" rel="noopener noreferrer">
    <img alt="codecov" src="https://codecov.io/gh/AndrGab/MediRepo/branch/main/graph/badge.svg?token=9WER8Z15AZ">
  </a>
  
  <a href="https://github.com/AndrGab/MediRepo/actions/workflows/elixir.yml" target="_blank" rel="noopener noreferrer">
    <img alt="elixir ci" src="https://github.com/AndrGab/MediRepo/actions/workflows/elixir.yml/badge.svg?branch=main">
  </a>

  <img alt="GitHub" src="https://img.shields.io/github/license/Andrgab/MediRepo?color=ff69b4">
</p>


# Medirepo - Daily Medical Report API

[![postman](https://img.shields.io/badge/documentation%20in-postman-orange?logo=postman)](https://documenter.getpostman.com/view/15643514/TzXwFJdM)

## MediRepo

Most hospitals are restricting visitors for COVID-19 Patients.
This is a personal project to help hospitals sharing Daily Medical Reports with those patients family.

  
## Technologies
Technologies used to write this API:

- Elixir;
- Phoenix;
- Exmachina;
- Excoveralls;
- Credo;
- Bamboo;
- PostgreSQL.
  
## Screenshots

![image](https://user-images.githubusercontent.com/57791712/118586539-54fd3580-b771-11eb-8f55-1ea2f0c2ee35.png)

  
## Lessons Learned

- JWT Authetication;
- PostgreSQL query;
- Changeset validation;

## Installation 

Install my-project with mix

```elixir
~# mix phx.new medirepo --no-webpack --no-html


~/medirepo# deps.get

~/medirepo# mix credo.gen.config

~/medirepo# mix credo

~/medirepo# mix ecto.create

~/medirepo# mix ecto.gen.migration create_hospitals_table

~/medirepo# mix ecto.gen.migration create_bulletins_table

~/medirepo# mix ecto.migrate
```
    
## Feedback

If you have any feedback, please reach out to me at andrgab@gmail.com

  
## Authors

Made with :purple_heart: by [@andrgab](https://www.github.com/andrgab)

  