library(dplyr)
library(readr)

flight_url <- function(year, month) {
  base_url <- "https://www.transtats.bts.gov/PREZIP/"
  sprintf(
    paste0(base_url, "On_Time_Reporting_Carrier_On_Time_Performance_1987_present_%d_%d.zip"),
    year, month
  )
}

download_month <- function(year, month) {
  file_url <- flight_url(year, month)

  temp <- tempfile(fileext = ".zip")
  download.file(file_url, temp)

  files <- unzip(temp, list = TRUE)
  # Only extract biggest file
  csv <- files$Name[order(files$Length, decreasing = TRUE)[1]]

  unzip(temp, exdir = "data-raw/flights", junkpaths = TRUE, files = csv)

  src <- paste0("data-raw/flights/", csv)
  dst <- paste0("data-raw/flights/", year, "-", month, ".csv")
  file.rename(src, dst)
}

download_year <- function(year) {
  file_months <- 1:12
  files_needed <- paste0(year, "-", file_months, ".csv")
  files_missing <- file_months[!(files_needed %in% dir("data-raw/flights"))]

  lapply(files_missing, download_month, year = year)
}

years <- 2013:2015

lapply(years, download_year)

get_msp <- function(path) {
  col_types <- cols(
    DepTime = col_integer(),
    ArrTime = col_integer(),
    CRSDepTime = col_integer(),
    CRSArrTime = col_integer(),
    Reporting_Airline = col_character()
  )
  read_csv(path, col_types = col_types) |>
    select(
      year = "Year", month = "Month", day = "DayofMonth",
      dep_time = "DepTime", sched_dep_time = "CRSDepTime", dep_delay = "DepDelay",
      arr_time = "ArrTime", sched_arr_time = "CRSArrTime", arr_delay = "ArrDelay",
      carrier = "Reporting_Airline", flight = "Flight_Number_Reporting_Airline",
      tailnum = "Tail_Number", origin = "Origin", dest = "Dest",
      air_time = "AirTime", distance = "Distance"
    ) |>
    filter(.data$origin == "MSP") |>
    mutate(
      hour = .data$sched_dep_time %/% 100,
      minute = .data$sched_dep_time %% 100,
      time_hour = lubridate::make_datetime(
        .data$year, .data$month, .data$day, .data$hour, 0, 0,
        tz = "America/Chicago"
      )
    ) |>
    arrange(.data$year, .data$month, .data$day, .data$dep_time)
}

all <- lapply(dir("data-raw/flights", full.names = TRUE), get_msp)
flights <- bind_rows(all)
flights$tailnum[!nzchar(flights$tailnum, keepNA = TRUE)] <- NA

write_csv(flights, "data-raw/flights.csv")
save(flights, file = "data/flights.rda", compress = "bzip2")
