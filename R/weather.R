#' Hourly weather data
#'
#' Hourly meteorological data for MSP, 2013-2015.
#'
#' @source ASOS download from Iowa Environmental Mesonet,
#'   <https://mesonet.agron.iastate.edu/request/download.phtml>.
#' @format A data frame with columns:
#' \describe{
#' \item{origin}{Weather station. Named `origin` to facilitate merging with
#'   [`flights`] data.}
#' \item{year, month, day, hour}{Time of recording.}
#' \item{temp, dewp}{Temperature and dewpoint in F.}
#' \item{humid}{Relative humidity.}
#' \item{wind_dir, wind_speed, wind_gust}{Wind direction (in degrees), speed
#'   and gust speed (in mph).}
#' \item{precip}{Precipitation, in inches.}
#' \item{pressure}{Sea level pressure in millibars.}
#' \item{visib}{Visibility in miles.}
#' \item{time_hour}{Date and hour of the recording as a `POSIXct` date.}
#' }
"weather"
