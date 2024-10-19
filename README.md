Here's an improved version with a refined structure, enhanced readability, and consistent styling:

---

<h1 align="center">
  <img alt="MediRepo Logo" src="https://user-images.githubusercontent.com/57791712/194556500-f4291b47-325e-43b2-adb6-e224152fd327.png">
</h1>

<h3 align="center">
  Elixir/Phoenix API for Daily Medical Reports
</h3>

<p align="center">Streamlining communication between Hospitals and Patients' Families</p>

<p align="center">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/Andrgab/MediRepo?color=ff69b4&logo=elixir">
  <a href="https://www.linkedin.com/in/andrgab/" target="_blank" rel="noopener noreferrer">
    <img alt="Made by" src="https://img.shields.io/badge/made%20by-Andre%20Gabriel-ff69b4?logo=linkedin">
  </a>
  <a href="https://codecov.io/gh/AndrGab/MediRepo" target="_blank" rel="noopener noreferrer">
    <img alt="Coverage" src="https://codecov.io/gh/AndrGab/MediRepo/branch/main/graph/badge.svg?token=9WER8Z15AZ">
  </a>
  <a href="https://github.com/AndrGab/MediRepo/actions/workflows/elixir.yml" target="_blank" rel="noopener noreferrer">
    <img alt="CI Status" src="https://github.com/AndrGab/MediRepo/actions/workflows/elixir.yml/badge.svg?branch=main">
  </a>
  <img alt="License" src="https://img.shields.io/github/license/Andrgab/MediRepo?color=ff69b4">
</p>

---

## 🚀 Introduction

**MediRepo** is an Elixir/Phoenix API that simplifies communication between hospitals and families by sharing daily medical reports. Especially useful during COVID-19 restrictions on hospital visits, it helps keep families informed while reducing the stress of uncertainty.

## 💻 Front End

Check out the corresponding front-end built with React:
**[MediRepo Web Repository](https://github.com/AndrGab/medirepoWeb)**

## 🌐 Live Demo

Explore the live demo of MediRepo:
**[MediRepo Demo](https://medirepo.vercel.app/)**

---

## 📚 How to Use MediRepo

### 🏥 For Hospitals

**API Documentation:** Access our detailed API documentation on Postman:
[![Postman Documentation](https://img.shields.io/badge/documentation%20in-postman-orange?logo=postman)](https://documenter.getpostman.com/view/15643514/TzzBpFsL)

1. **Register a hospital account** through the API.
2. **Submit daily medical reports** using our endpoints.
3. Share the **Patient Code** and **Attendance Code** (password) with the patient's family.

Families can access the latest report using these codes, ensuring secure and straightforward communication. You can integrate MediRepo API with your main hospital system for automated updates, or use the web interface for manual entry.

### 👨‍👩‍👧‍👦 For Patients' Families

Use our intuitive interface at **[MediRepo Web](https://medirepo.vercel.app/)** to view the medical reports shared by the hospital.

---

## ⚙️ Local Setup Guide

1. **Fork and Clone** the repository:

   ```bash
   git clone git@github.com:<your-user-name>/medirepo.git
   ```

2. **Install dependencies** (refer to `.tool-versions` for version details):

   ```bash
   mix deps.get
   ```

3. **Start PostgreSQL** to support the database.

4. **Set up the database**:

   ```bash
   mix ecto.setup
   ```

5. **Configure environment variables** using the `.env-sample` file, including your SMTP server details for email notifications. During development, view sent emails at `localhost:4000/sent_emails` using Bamboo viewer.

6. **Run the application**:

   ```bash
   iex -S mix phx.server
   ```

---

## 🤝 Contributing

Check out our [Contributing Guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md). You can help by:

- Adding new features
- Improving architecture
- Fixing bugs
- Expanding test coverage
- Starring the project ⭐

**We welcome your contributions!**

---

## 🎃 HacktoberFest

Contribute to this project as part of **[Hacktoberfest](https://hacktoberfest.com/)**!

### What is Hacktoberfest?

Hacktoberfest, organized by DigitalOcean, is a month-long celebration encouraging contributions to open-source projects. It’s a great way to give back to the community, sharpen your skills, and support projects that make a difference.

[Learn more about Hacktoberfest](https://hacktoberfest.com/)

---

## 📸 Screenshots

![Bulletin Example](https://user-images.githubusercontent.com/57791712/119598328-1f7fca00-bdb9-11eb-87a9-7b4ee4c35ee0.gif)

---

## 📬 Feedback

Have any feedback? Feel free to reach out to me at **andrgab@gmail.com**

## 👤 Author

Made with 💜 by **Andre Gabriel**

<a href="https://www.linkedin.com/in/andrgab/" target="_blank" rel="noopener noreferrer">
    <img alt="LinkedIn" src="https://img.shields.io/badge/connect%20with-Andre%20Gabriel-ff69b4?logo=linkedin">
</a>

## 🌟 Contributors

<a href="https://github.com/andrgab/medirepo/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=andrgab/medirepo" alt="Contributors">
</a>

---

## 🏅 Credits

Contributors image created with [contrib.rocks](https://contrib.rocks).
