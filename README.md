<h1 align="center">
  <img alt="Logo" src="https://user-images.githubusercontent.com/57791712/194556500-f4291b47-325e-43b2-adb6-e224152fd327.png">
</h1>

<h3 align="center">
  Elixir/Phoenix API for Daily Medical Reports
</h3>

<p align="center">Making communication easier for Hospitals and Patients' Families</p>

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

## MediRepo

Most hospitals are restricting visitors for COVID-19 Patients.
This is a project to help hospitals to share Daily Medical Reports with those patients' families.

## Front End

Front-end (React) repository:
https://github.com/AndrGab/medirepoWeb

## Live Demo

Access the demo application:

<a href="https://medirepo.vercel.app/" target="_blank" rel="noopener noreferrer">
    https://medirepo.vercel.app/
  </a>

## How to use MediRepo

### Hospitals

See API documentation:

[![postman](https://img.shields.io/badge/documentation%20in-postman-orange?logo=postman)](https://documenter.getpostman.com/view/15643514/TzzBpFsL)

1. Use you API to create an account
2. Send new bulletins to our endpoint
3. Share the Patient Code and Attendance Code (this is the password) to the patient's family

Using the same patient Code and attendance Code, only the last medical report will be shared.

With Medirepo API you can send medical reports to the application easier, set up your main application to communicate with our REST API.

You can use the frontend application to create/edit bulletins manually.

### Patient's Family

1. They should use our [MediRepoWeb](https://medirepo.vercel.app/) (user friendly interface)

## Guide to set up locally

1. Fork the project and then clone it to your computer

```
git clone git@github.com:<your-user-name>/medirepo.git
```

2. Install libs
   (`.tool-versions` file has versions especifications)

```
mix deps.get
```

3. Postgres must be running

4. Setup Database

```
mix ecto.setup
```

5. Use `.env-sample` file to create your environment variables, set your username/password to your SMTP server, if don't have one just create with any name. In Dev environment you can access sent emails using Bamboo viewer (localhost:4000/sent_emails).

6. Run the project

```
iex -S mix phx.server
```

## Contributing

See you [contributing guidelines](CONTRIBUTING.md) and our [Code of condute.](CODE_OF_CONDUCT.md)

You can contribute to this project including:

- new features;
- architectural improvements;
- searching bugs;
- adding test coverage;
- starring the project :star:

Feel free to contribute!

## HacktoberFest

If you came here for Hacktoberfest:

Celebrate [Hacktoberfest](https://hacktoberfest.com/) by getting involved in the open source community by completing some tasks in this project.

This repository is open to all members of the GitHub community. Any member may contribute to this project without being a collaborator.

### What is Hacktoberfest?

🎃 HacktoberFest is digitalocean’s annual event that encourages people to contribute to open source throughout October. Much of modern tech infrastructure—including some of digitalocean’s own products—relies on open-source projects built and maintained by passionate people who often don’t have the staff or budgets to do much more than keeping the project alive. 🎃 HacktoberFest is all about giving back to those projects, sharpening skills, and celebrating all things open source, especially the people that make open source so special.

[https://hacktoberfest.com/](https://hacktoberfest.com/)

## Screenshots

![bulletin2](https://user-images.githubusercontent.com/57791712/119598328-1f7fca00-bdb9-11eb-87a9-7b4ee4c35ee0.gif)

## Feedback

If you have any feedback, please reach out to me at andrgab@gmail.com

## Author

Made with :purple_heart:

 <a href="https://www.linkedin.com/in/andrgab/" target="_blank" rel="noopener noreferrer">
    <img alt="Made by" src="https://img.shields.io/badge/made%20by-Andre%20Gabriel-ff69b4?logo=linkedin">
 </a>

## Contributors

<a href="https://github.com/andrgab/medirepo/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=andrgab/medirepo" />
</a>

## Credits

Contributors image made with [contrib.rocks](https://contrib.rocks).
