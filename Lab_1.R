library(ggplot2)

setwd("C:\\Users\\mdkai\\Data Visualization and Handling\\ml-100k\\ml-100k")


# ratings data
ratings <- read.table("u.data", sep = "\t", col.names = c("user_id", "movie_id", "rating", "timestamp"))

# user demographics
users <- read.table("u.user", sep = "|", col.names = c("user_id", "age", "gender", "occupation", "zip_code"))

# movie info with genres
movies <- read.table("u.item", sep = "|", quote = "", fill = TRUE, encoding = "latin1",
                     col.names = c("movie_id", "title", "release_date", "video_release_date", "IMDb_URL",
                                   "unknown", "Action", "Adventure", "Animation", "Children", "Comedy", "Crime",
                                   "Documentary", "Drama", "Fantasy", "FilmNoir", "Horror", "Musical", "Mystery",
                                   "Romance", "SciFi", "Thriller", "War", "Western"))

# merge step by step
merged <- merge(ratings, users, by = "user_id")
merged <- merge(merged, movies, by = "movie_id")

#1
genre_cols <- 7:24
avg_rating_genre <- data.frame()

for (i in genre_cols) {
  g <- names(movies)[i]
  r <- merged[merged[[g]] == 1, ]
  avg_rating_genre <- rbind(avg_rating_genre, data.frame(Genre = g, AvgRating = mean(r$rating)))
}


ggplot(avg_rating_genre, aes(x = reorder(Genre, AvgRating), y = AvgRating)) +
  geom_col(fill = "purple") +
  coord_flip() +
  labs(title = "Average Rating of all Genres", x = "Genre", y = "Average Rating")+
  annotate( "text" , x = 18, y = 5, label = "Owais", color = "black", size = 5)


#2


# Count number of ratings for each genre
genre_popularity <- movies %>%
  pivot_longer(cols = 7:24, names_to = "Genre", values_to = "is_genre") %>%
  filter(is_genre == 1) %>%
  group_by(Genre) %>%
  summarise(NumRatings = n()) %>%
  arrange(desc(NumRatings))

ggplot(genre_popularity, aes(x = reorder(Genre, NumRatings), y = NumRatings)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Most Popular Genres by Number of Ratings",
       x = "Genre", 
       y = "Number of Ratings")+
  annotate( "text" , x = 15, y = 700, label = "Owais", color = "black", size = 5)


#3

movie_counts <- aggregate(rating ~ title, data = merged, length)
top10 <- movie_counts[order(-movie_counts$rating), ][1:10, ]
names(top10) <- c("Title", "NumRatings")

ggplot(top10, aes(x = reorder(Title, NumRatings), y = NumRatings)) +
  geom_col(fill = "purple") +
  coord_flip() +
  labs(title = "Top 10 Movies by Number of Ratings", x = "Movie Title", y = "Number of Ratings")+
  annotate( "text" , x = 9, y = 600, label = "Owais", color = "black", size = 5)

#4
genre_gender_ratings <- merged %>%
  pivot_longer(cols = 14:31, names_to = "Genre", values_to = "is_genre") %>%
  filter(is_genre == 1) %>%
  group_by(Genre, gender) %>%
  summarise(AvgRating = mean(rating), .groups = "drop")

ggplot(genre_gender_ratings, aes(x = reorder(Genre, AvgRating), y = AvgRating, fill = gender)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Average Rating Genre by Gender",
       x = "Genre",
       y = "Average Rating",
       fill = "Gender") +
  scale_fill_manual(values = c("M" = "steelblue", "F" = "pink"))+
  annotate( "text" , x = 17, y = 5, label = "Owais", color = "black", size = 5)


#5 Do male and female users rate  more movies on average

# Calculate average movies rated by gender
ratings_per_user <- merged %>%
  group_by(user_id, gender) %>%
  summarise(NumRatings = n(), .groups = "drop") %>%
  group_by(gender) %>%
  summarise(AverageMoviesRated = mean(NumRatings))

ggplot(ratings_per_user, aes(x = gender, y = AverageMoviesRated, fill = gender)) +
  geom_col(width = 0.6) +
  labs(title = "Average Number of Movies Rated by Gender",
       x = "Gender",
       y = "Average Movies Rated") +
  scale_fill_manual(values = c("M" = "steelblue", "F" = "pink")) +
  theme_minimal()+
  annotate( "text" , x = 2.5, y = 110, label = "Owais", color = "black", size = 5)


#6
top_movies_per_genre <- merged %>%
  pivot_longer(cols = 14:31, names_to = "Genre", values_to = "is_genre") %>%
  filter(is_genre == 1) %>%
  group_by(Genre, title) %>%
  summarise(AvgRating = mean(rating), NumRatings = n(), .groups = "drop") %>%
  filter(NumRatings >= 20) %>%  # avoid outliers with tiny sample size
  group_by(Genre) %>%
  filter(AvgRating == max(AvgRating)) %>%
  arrange(Genre)

# Plot
ggplot(top_movies_per_genre, aes(x = reorder(Genre, AvgRating), y = AvgRating, fill = Genre)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  geom_text(aes(label = paste0(title, " (", round(AvgRating, 2), ")")),
            hjust = -0.1, size = 3.5) +
  labs(
    title = "Highest Rated Movie in Each Genre",
    x = "Genre",
    y = "Average Rating"
  ) +
  ylim(0, 5) +
  theme_minimal()+
  annotate( "text" , x = 18.5, y = 5, label = "Owais", color = "black", size = 5)

#7 how do ratings vary across different age groups
merged <- merged %>%
  mutate(age_group = cut(
    age,
    breaks = c(0, 17, 24, 34, 44, 54, 64, 100),
    labels = c("<18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+"),
    right = TRUE
  ))

# Calculate average rating per age group
avg_rating_age <- merged %>%
  group_by(age_group) %>%
  summarise(AvgRating = mean(rating), .groups = "drop")

# Plot
ggplot(avg_rating_age, aes(x = age_group, y = AvgRating)) +
  geom_col(fill = "skyblue") +
  geom_text(aes(label = round(AvgRating, 2)), vjust = -0.5) +
  labs(
    title = "Average Movie Ratings by Age Group",
    x = "Age Group",
    y = "Average Rating"
  ) +
  ylim(0, 5) +
  theme_minimal()+
  annotate( "text" , x = 7, y = 4.8, label = "Owais", color = "black", size = 5)


#8 How do ratings vary across different occupations
avg_rating_occupation <- merged %>%
  group_by(occupation) %>%
  summarise(AvgRating = mean(rating), .groups = "drop") %>%
  arrange(desc(AvgRating))

# Plot
ggplot(avg_rating_occupation, aes(x = reorder(occupation, AvgRating), y = AvgRating)) +
  geom_col(fill = "coral") +
  geom_text(aes(label = round(AvgRating, 2)), hjust = -0.1) +
  coord_flip() +
  labs(
    title = "Average Movie Ratings by Occupation",
    x = "Occupation",
    y = "Average Rating"
  ) +
  ylim(0, 5) +
  theme_minimal()+
  annotate( "text" , x = 20, y = 4.8, label = "Owais", color = "black", size = 5)

#9 which genres are preferres by different age groups
merged <- merged %>%
  mutate(age_group = cut(
    age,
    breaks = c(0, 17, 24, 34, 44, 54, 64, 100),
    labels = c("<18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+"),
    right = TRUE
  ))

# Step 2: Reshape to long format (one row per genre)
genre_long <- merged %>%
  pivot_longer(cols = 14:31, names_to = "Genre", values_to = "is_genre") %>%
  filter(is_genre == 1)

# Step 3: Calculate average rating per age group and genre
avg_genre_age <- genre_long %>%
  group_by(age_group, Genre) %>%
  summarise(AvgRating = mean(rating), .groups = "drop")

# Step 4: Plot (heatmap to compare preferences)
ggplot(avg_genre_age, aes(x = age_group, y = Genre, fill = AvgRating)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(
    title = "Average Ratings of Genres by Age Group",
    x = "Age Group",
    y = "Genre",
    fill = "Avg Rating"
  ) +
  theme_minimal()+
  annotate( "text" , x = 7, y = 7, label = "Owais", color = "black", size = 5)

#10 How user preferences evolveed over time

library(lubridate)

# Step 1: Convert timestamp to year
merged <- merged %>%
  mutate(rating_year = year(as_datetime(timestamp)))

# Step 2: Reshape to long format
genre_long <- merged %>%
  pivot_longer(cols = 14:31, names_to = "Genre", values_to = "is_genre") %>%
  filter(is_genre == 1)

# Step 3: Count number of ratings per year and genre
genre_trend <- genre_long %>%
  group_by(rating_year, Genre) %>%
  summarise(Count = n(), .groups = "drop")

# Step 4: Plot genre popularity over time
ggplot(genre_trend, aes(x = rating_year, y = Count, color = Genre)) +
  geom_line(size = 1) +
  labs(
    title = "Genre Popularity Over Time",
    x = "Year of Rating",
    y = "Number of Ratings",
    color = "Genre"
  ) +
  theme_minimal()+
  annotate( "text" , x = 1998.01, y = 19000, label = "Owais", color = "black", size = 5)