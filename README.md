# Shiny Enterprise Dashboard
`ver. 1.0.0`

This is a template based on an html template and styled by Appsilon. This template contains multiple components (e.g., map, charts, KPIs). Each component is defined as a separate module which makes it easy to reuse. You can use them to build your own application. We added example data so you can run an example application after downloading the template. 

We encourage you to try to add your own elements and style them based on the examples in the application!

Tech stack:
- Shiny / htmlTemplate
- Sass, CSS Grid

## Installation
---
- Make sure that you have [renv]("https://rstudio.github.io/renv/articles/renv.html) package installed 
- Open main directory and run `renv::restore()`
- Run the application

## App folder structure
---
### **root directory**
The main part of the application is divided into 3 files located in the root directory: `global.R`, `ui.R`, and `server.R`. It helps organize the structure, especially in more complex apps. Any R objects that are created in the `global.R` file are available to the `ui.R` and `server.R` files. 

Root directory also contains `constants.R` file with constant variables, where you can adjust items such as color values, text visible as labels or some reusable elements (e.g., logo).

### **data**
Here you can find example data used in the application.

### **modules**
Here you can find the `modules` composed of ui, init_server and server functions, managed by modules R package. This is a place where you can add new components or modify existing ones.

### **utilities**
Here you can store helper R functions used across the entire app.

### **styles**
This folder contains `scss` files with UI styling. All the sass files imported to `main.scss` are compiled into a single css file in `www` directory by [sass]("https://rstudio.github.io/sass/index.html") package, every time you run the app. Sass files are initially divided into `config` and `partials`. If you add or remove some file, you need to import or remove it from `main.scss` as well. 

### **www**
This folder contains the `css` file compiled from Sass files, `html` file template and `assets` folder with graphics.

### **renv**
Here you can find the `renv` package configuration folder. This package manager is necessary to install all dependencies used in this application.

## UI Components
---
- headers with `SVG` logos
- styled `filters`
- `metrics` displaying dynamic values based on the dropdowns selection
- map created with `echarts4r` package
- vertical bar chart created with `ggplot2` package
- horizontal bar chart created with `dygraphs` package
- footer with the link to `Appsilon's Shiny Marketplace` - (Please do not remove this.)
