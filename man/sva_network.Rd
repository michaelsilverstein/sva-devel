% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sva_network.R
\name{sva_network}
\alias{sva_network}
\title{A function to adjust gene expression data before network inference}
\usage{
sva_network(dat, n.pc)
}
\arguments{
\item{dat}{The uncorrected normalized gene expression data matrix with samples in rows and genes in columns}

\item{n.pc}{The number of principal components to remove}
}
\value{
dat.adjusted Cleaned gene expression data matrix with the top prinicpal components removed
}
\description{
This function corrects a gene expression matrix prior to network inference by
returning the residuals after regressing out the top principal components. 
The number of principal components to remove can be determined using a 
permutation-based approach using the "num.sv" function with method = "be"
}
\examples{
library(bladderbatch)
data(bladderdata)
dat <- bladderEset[1:5000,]

edata = exprs(dat)
mod = matrix(1, nrow = dim(dat)[2], ncol = 1)

n.pc = num.sv(edata, mod, method="be")
dat.adjusted = sva_network(t(edata), n.pc)

}
