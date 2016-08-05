#' Haplo object construct
#'
#' A Haplo object contains a collection of haplotypes, their frequency, and total count
#'
#' @param h A haplotype matrix (matrix of characters with rows giving haplotypes)
#' @param pi A numeric vector giving frequencies of haplotypes
#' @param count The total coverage, may be NA if this is not well-defined
#'
#' @return A Haplo object
#' @export
Haplo <- function(h, pi, count=NA)
{
  if (class(h) != "matrix" | class(pi) != "numeric")
    stop("h or pi are not of right class")
  if (nrow(h) != length(pi))
    stop("h and pi do not imply the same number of haplotypes")

  h_seq <- aaply(h, 1, paste, collapse="")
  # if h is empty, make this a empty character vector
  if (length(h_seq)==0)
    h_seq <- as.character(c())

  ind <- order(pi, decreasing = T)

  h <- h[ind,,drop=F]
  pi <- pi[ind]
  h_seq <- h_seq[ind]

  H <- list(h=h, pi=pi, count=count, h_seq=h_seq)

  class(H) <- c("Haplo", "list")
  return (H)
}

get_hap.Haplo <- function(H)
{
  return (H$h)
}

get_nhap.Haplo <- function(H)
{
  return (nrow(get_hap.Haplo(H)))
}

get_hap_seq.Haplo <- function(H)
{
  return (H$h_seq)
}

get_freq.Haplo <- function(H)
{
  return (H$pi)
}

get_count.Haplo <- function(H)
{
  return (H$count)
}

get_nhap.Haplo <- function(H)
{
  return (length(H$pi))
}

#' Set the position names for the characters (nucleotides) forming the haplotypes.
#'
#' Alters the colnames of the haplotype matrix
#' to reflect pos names.   This is meant for visual purposes.   The Haplo object never accesses
#' these names.
#'
#' @param H A Haplo object
#' @param pos_names A character vector giving position names
set_pos_names.Haplo <- function(H, pos_names)
{
  h <- get_hap.Haplo(H)
  if (ncol(h) != length(pos_names))
    stop("h and pos_names imply different number of characters in haplotypes")

  colnames(H$h) <- pos_names

  return (H)
}

###########################################################################
plot.Haplo <- function(H, p=NULL, facet_label=NULL)
{
  pos <- rep(NA, get_nh.Haplo(H))
  HL <- HaploLocus(H, pos)

  return (plot.HaploLocus(HL, p, facet_label))
}

write.Haplo <- function(H, outfile)
{
  h <- get_hap.Haplo(H)
  f <- get_freq.Haplo(H)

  h_f <- cbind(f, h)
  write.table(h_f, outfile, row.names=F, col.names=F, sep=",")

  return (NULL)
}

read.Haplo <- function(infile)
{
  h_f <- read.table(infile, sep=",", colClasses="character")
  f <- as.numeric(h_f[,1])
  h <- as.matrix(h_f[,2:ncol(h_f)])

  return (Haplo(h, f))
}