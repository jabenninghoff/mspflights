#' Flights data
#'
#' On-time data for all flights that departed Minneapolis-Saint Paul International Airport (MSP),
#'   2013-2015.
#'
#' @source RITA, Bureau of transportation statistics,
#'  <https://www.transtats.bts.gov/DL_SelectFields.aspx?gnoyr_VQ=FGJ&QO_fu146_anzr=b0-gvzr>
#' @format Data frame with columns
#' \describe{
#' \item{year, month, day}{Date of departure.}
#' \item{dep_time, arr_time}{Actual departure and arrival times (format HHMM or HMM), local tz.}
#' \item{sched_dep_time, sched_arr_time}{Scheduled departure and arrival times (format HHMM or HMM),
#'   local tz.}
#' \item{dep_delay, arr_delay}{Departure and arrival delays, in minutes.
#'   Negative times represent early departures/arrivals.}
#' \item{carrier}{Two letter carrier abbreviation. See [`airlines`]
#'   to get name.}
#' \item{flight}{Flight number.}
#' \item{tailnum}{Plane tail number. See [`planes`] for additional metadata.}
#' \item{origin, dest}{Origin and destination. See [`airports`] for
#'   additional metadata.}
#' \item{air_time}{Amount of time spent in the air, in minutes.}
#' \item{distance}{Distance between airports, in miles.}
#' \item{hour, minute}{Time of scheduled departure broken into hour and minutes.}
#' \item{time_hour}{Scheduled date and hour of the flight as a `POSIXct` date.
#'   Along with `origin`, can be used to join flights data to [`weather`] data.}
#' }
"flights"

#' @importFrom tibble tibble
NULL
