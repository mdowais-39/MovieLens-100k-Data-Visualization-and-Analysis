# 🎥 MovieLens 100k Data Visualization Project

![MovieLens Banner](https://img.shields.io/badge/Dataset-MovieLens%20100k-blueviolet) ![R Version](https://img.shields.io/badge/R-4.0%2B-brightgreen) ![License](https://img.shields.io/badge/License-MIT-yellow)

## 🌟 Overview
Welcome to the MovieLens 100k Data Visualization Project! This repository houses an engaging R-based analysis of the classic MovieLens 100k dataset. Dive into the world of movie ratings, user demographics, and genre trends through a series of insightful visualizations created with ggplot2.

Whether you're a data enthusiast, a film buff, or just curious about user preferences in movies, this project uncovers patterns like average ratings by genre, gender differences in tastes, age group preferences, and even how genre popularity evolves over time. All visualizations include a subtle annotation as a watermark.

## 📊 Dataset
The [MovieLens 100k dataset](https://grouplens.org/datasets/movielens/100k/) is a staple in recommendation systems research. It includes:
- **100,000 ratings** from 943 users on 1,682 movies.
- User demographics (age, gender, occupation, zip code).
- Movie details (title, release date, genres).

Key files used:
- `u.data`: Ratings.
- `u.user`: User info.
- `u.item`: Movie info with genres.

Download the dataset and place it in a `data/ml-100k/` directory within the repo for easy access.

## 🔍 Visualizations
This project features 10 stunning visualizations, each revealing unique insights:

1. **Average Rating of All Genres**  
   A bar chart showing the mean rating for each genre, highlighting favorites like Film-Noir and Drama.

2. **Most Popular Genres by Number of Ratings**  
   Bar chart ranking genres by popularity based on rating counts—Drama and Comedy often top the list!

3. **Top 10 Movies by Number of Ratings**  
   Discover the most-rated movies, like Star Wars or Pulp Fiction, in this flipped bar chart.

4. **Average Rating by Genre and Gender**  
   Grouped bar chart comparing how males and females rate different genres—spot the differences!

5. **Average Number of Movies Rated by Gender**  
   A simple bar chart illustrating if one gender rates more movies on average.

6. **Highest Rated Movie in Each Genre**  
   Bar chart with labels showing the top-rated movie per genre (filtered for at least 20 ratings).

7. **Average Movie Ratings by Age Group**  
   Explore how ratings vary across age brackets, from <18 to 65+.

8. **Average Movie Ratings by Occupation**  
   See if artists rate higher than engineers in this occupation-based bar chart.

9. **Average Ratings of Genres by Age Group**  
   A heatmap visualizing genre preferences across age groups—perfect for spotting trends like younger users loving Sci-Fi.

10. **Genre Popularity Over Time**  
    Line chart tracking the number of ratings per genre by year, showing evolving user interests.

All plots are generated in `Lab_1.R` and can be customized further.

## 🛠️ Setup Instructions
1. **Clone the Repository**:
   ```
   git clone [https://github.com/mdowais-39/MovieLens-100k-Data-Visualization-and-Analysis]
   cd movielens-100k-viz
   ```

2. **Download the Dataset**:
   - Head to [GroupLens](https://grouplens.org/datasets/movielens/100k/).
   - Extract to `data/ml-100k/` (adjust `setwd()` in the script if needed).

3. **Install R Packages**:
   Run the following in R to install dependencies:
   ```R
   install.packages(c("ggplot2", "dplyr", "tidyr", "lubridate"))
   ```

4. **Run the Script**:
   Open `Lab_1.R` in RStudio or your preferred R environment and source it:
   ```R
   source("Lab_1.R")
   ```
   This will load the data, merge it, and generate all visualizations.

## 📋 Requirements
- **R Version**: 4.0 or higher.
- **Packages**:
  - ggplot2 (for plotting)
  - dplyr (for data manipulation with %>%)
  - tidyr (for pivot_longer)
  - lubridate (for date handling)

Install them via the command above. No additional setup required—base R handles the rest!

## 🚀 Usage
- Modify `setwd()` to point to your dataset path.
- Run the script to generate plots interactively.
- Export plots with `ggsave()` if needed (e.g., `ggsave("plot1.png", plot_object)`).

## 🤝 Contributing
Love movies or data viz? Fork this repo, add new insights (e.g., more advanced stats or interactive plots with shiny), and submit a pull request. Issues and suggestions are welcome!

## 📄 License
This project is licensed under the MIT License—feel free to use and adapt.

Happy visualizing! 🍿
