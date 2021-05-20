# Daily Medical Report
[![codecov](https://codecov.io/gh/AndrGab/MediRepo/branch/main/graph/badge.svg?token=9WER8Z15AZ)](https://codecov.io/gh/AndrGab/MediRepo)


## MediRepo

Most hospitals are restricting visitors for
COVID-19 Patients.
This is a personal project to help hospitals sharing
Daily Medical Reports with these patients' families.

  
## Tech Stack

**Server:** Elixir, Phoenix

  
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

If you have any feedback, please reach out to us at andrgab@gmail.com

  
## Authors

- [@andrgab](https://www.github.com/andrgab)

  