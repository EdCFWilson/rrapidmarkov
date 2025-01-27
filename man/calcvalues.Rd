% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rrapidmarkovFunctions.R
\name{calcvalues}
\alias{calcvalues}
\title{Calculate values (eg costs and QALYs)}
\usage{
calcvalues(
  markovTrace,
  stateValues,
  transPeriod = 1,
  discountRate = 0.035,
  QALYs = FALSE
)
}
\arguments{
\item{markovTrace}{Output of runmarkov()}

\item{stateValues}{Vector of state values (eg costs or health state
utilities).  Must be of length = number of states.}

\item{transPeriod}{Model transition period.  Must be entered as a fraction
of a year.  Eg day = 1/365, week = 1/52, calendar month = 1/12, lunar
(4-week) month = 1/13.}

\item{discountRate}{Annual discount rate.}

\item{QALYs}{Set to true when calculating QALYs from health state utilities
to adjust for the transition period (eg if transitionPeriod = 1/2, then 1
cycle in full health = 0.5 QALYs)}
}
\value{
A list comprising:

  $undisc - matrix of size (cycles+1) x (states+1) reporting undiscounted
  values by state and cycle.  Final column = row totals, final row = column
  totals.

  $disc - matrix as per $undisc, discounted at specified rate per annum.

  $totalUndisc - total undiscounted value (= bottom right value of $undisc)

  $totalDisc - total discounted value (= bottom right value of $disc)

  $transPeriod - transition period used in model in years

  $discountRate - annual discount rate used.
}
\description{
Multiplies output of runmarkov() by state costs, utilities or other value
}
\examples{
states <- c("alive", "progressive", "dead")
startingStates <- c(1, 0, 0)
cycles <- 10
transitionsMatrix <- matrix(data = c(0.8, 0.1, 0.1,
                                     0.0, 0.7, 0.3,
                                     0.0, 0.0, 1.0),
                                     ncol = 3, byrow = TRUE)

output <- runmarkov(transitionsMatrix, startingStates, cycles, states)
stateCosts <- c(100, 1000, 0)
stateUtilities <- c(0.8, 0.5, 0)

calcvalues(output, stateCosts)
calcvalues(output, stateUtilities, QALYs = TRUE)
}
