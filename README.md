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

## Introduction

MediRepo is an Elixir/Phoenix API designed to facilitate communication between hospitals and patients' families by sharing Daily Medical Reports. In the midst of COVID-19 restrictions on hospital visits, this project aims to bridge the gap and provide essential medical information to concerned families.

## Front End

For the corresponding front-end (React) repository, visit:
[MediRepo Web Repository](https://github.com/AndrGab/medirepoWeb)

## Live Demo

Experience the live demo application by visiting:
[MediRepo Demo](https://medirepo.vercel.app/)

## How to Use MediRepo

### For Hospitals

#### API Documentation

Access our comprehensive API documentation on Postman:
[![Postman Documentation](https://img.shields.io/badge/documentation%20in-postman-orange?logo=postman)](https://documenter.getpostman.com/view/15643514/TzzBpFsL)

1. Create a hospital account using our API.
2. Utilize our endpoint to submit daily medical bulletins.
3. Share the Patient Code and Attendance Code (password) with the patient's family.

By using the same Patient Code and Attendance Code, only the latest medical report will be shared automatically. Integrate MediRepo API with your main application to streamline medical report submission, or use the web application for manual bulletin creation and editing.

### For Patients' Families

1. Access the user-friendly interface of [MediRepo Web](https://medirepo.vercel.app/) to view medical reports.

## Local Setup Guide

1. Fork the project and clone it to your local computer:

```bash
git clone git@github.com:<your-user-name>/medirepo.git
```

2. Install required libraries (refer to `.tool-versions` file for version specifications):

```bash
mix deps.get
```

3. Ensure that Postgres is running.

4. Set up the database:

```bash
mix ecto.setup
```

5. Use the `.env-sample` file to create your environment variables. Configure your SMTP server username and password. If you don't have an SMTP server, you can create one with any name. In the development environment, you can access sent emails using Bamboo viewer (localhost:4000/sent_emails).

6. Run the project:

```bash
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

![Bulletin Example](https://user-images.githubusercontent.com/57791712/119598328-1f7fca00-bdb9-11eb-87a9-7b4ee4c35ee0.gif)


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
