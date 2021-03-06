% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_table.R
\name{template_indices.read_table}
\alias{template_indices.read_table}
\title{Return read indices corresponding to the template}
\usage{
template_indices.read_table(template, df)
}
\arguments{
\item{template}{A logical vector or matrix. If matrix, rows
contain templates.  Templates must be unique}

\item{df}{a read table}
}
\value{
A list containing indices in df or read groups (rows)
that have the given templates
}
\description{
Return read indices corresponding to the template
}
