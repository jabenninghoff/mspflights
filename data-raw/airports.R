library(dplyr)
library(readr)
library(ggplot2)

if (!file.exists("data-raw/airports.dat")) {
  download.file(
    "https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat",
    "data-raw/airports.dat"
  )
  readLines("data-raw/airports.dat") |>
    # run stri_trans_general first as iconv adds unwanted punctuation on macOS
    stringi::stri_trans_general("latin-ascii") |>
    # convert any remaining UTF-8 (2646,"Gral. Bernardo O'Higgins Airport")
    iconv(from = "utf-8", to = "ascii//translit") |>
    writeLines("data-raw/airports.dat")
}

raw <- read_csv("data-raw/airports.dat",
  col_names = c(
    "id", "name", "city", "country", "faa", "icao", "lat", "lon", "alt", "tz", "dst", "tzone"
  ),
  na = "\\N"
)

airports <- raw |>
  filter(country == "United States", nzchar(faa, keepNA = TRUE)) |>
  select(faa, name, lat, lon, alt, tz, dst, tzone) |>
  group_by(faa) |>
  slice(1) |>
  ungroup() # take first if duplicated

# Verify the results
airports |>
  filter(lon < 0) |>
  ggplot(aes(lon, lat)) +
  geom_point(aes(colour = factor(tzone)), show.legend = FALSE) +
  coord_quickmap() +
  theme_void()
ggsave("data-raw/airports.svg", width = 8, height = 6)

write_csv(airports, "data-raw/airports.csv")
save(airports, file = "data/airports.rda", version = 2)
