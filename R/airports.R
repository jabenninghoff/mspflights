#' Airport metadata
#'
#' Useful metadata about airports.
#'
#' @source <https://github.com/jpatokal/openflights/blob/master/data/airports.dat>, last updated
# nolint next: line_length_linter.
#'   [2019-05-13](https://github.com/jpatokal/openflights/blob/5234b5b72fafc727040cac42d2bb67d2a1d71f89/data/airports.dat)
#' @format A data frame with columns:
#' \describe{
#'  \item{faa}{FAA airport code.}
#'  \item{name}{Usual name of the airport.}
#'  \item{lat, lon}{Location of airport.}
#'  \item{alt}{Altitude, in feet.}
#'  \item{tz}{Timezone offset from GMT.}
#'  \item{dst}{Daylight savings time zone. A = Standard US DST: starts on the
#'     second Sunday of March, ends on the first Sunday of November.
#'     U = unknown. N = no dst.}
#'  \item{tzone}{IANA time zone, as determined by GeoNames webservice.}
#' }
#' @examples
#' airports
#'
#' if (require("dplyr")) {
#'   airports |>
#'     rename(dest = faa) |>
#'     semi_join(flights)
#'   flights |>
#'     anti_join(airports |> rename(dest = faa))
#'   airports |>
#'     rename(origin = faa) |>
#'     semi_join(flights)
#' }
"airports"
