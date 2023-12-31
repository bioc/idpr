% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/foldIndexR.R
\name{foldIndexR}
\alias{foldIndexR}
\title{Prediction of Intrinsic Disorder with FoldIndex method in R}
\usage{
foldIndexR(
  sequence,
  window = 51,
  proteinName = NA,
  pKaSet = "IPC_protein",
  plotResults = TRUE,
  ...
)
}
\arguments{
\item{sequence}{amino acid sequence as a single character string,
a vector of single characters, or an AAString object.
It also supports a single character string that specifies
the path to a .fasta or .fa file.}

\item{window}{a positive, odd integer. 51 by default.
Sets the size of sliding window, must be an odd number.
The window determines the number of residues to be analyzed and averaged
for each position along the sequence.}

\item{proteinName}{character string with length = 1.
optional setting to replace the name of the plot if plotResults = TRUE.}

\item{pKaSet}{A character string or data frame. "IPC_protein" by default.
Character string to load specific, preloaded pKa sets.
 c("EMBOSS", "DTASelect", "Solomons", "Sillero", "Rodwell",
  "Lehninger", "Toseland", "Thurlkill", "Nozaki", "Dawson",
  "Bjellqvist", "ProMoST", "Vollhardt", "IPC_protein", "IPC_peptide")
 Alternatively, the user may supply a custom pKa dataset.
 The format must be a data frame where:
 Column 1 must be a character vector of residues named "AA" AND
 Column 2 must be a numeric vector of pKa values.}

\item{plotResults}{logical value, TRUE by default.
If \code{plotResults = TRUE} a plot will be the output.
If \code{plotResults = FALSE} the output is a data frame with scores for
each window analyzed.}

\item{...}{any additional parameters, especially those for plotting.}
}
\value{
see plotResults argument
}
\description{
This is used to calculate the prediction of intrinsic disorder based on
  the scaled hydropathy and absolute net charge of an amino acid
  sequence using a sliding window. FoldIndex described this relationship and
  implemented it graphically in 2005 by Prilusky, Felder, et al,
  and this tool has been implemented
  into multiple disorder prediction programs. When windows have a negative
  score (<0) sequences are predicted as disordered.
  When windows have a positive score (>0) sequences are predicted as
  disordered. Graphically, this cutoff is displayed by the dashed
  line at y = 0. Calculations are at pH 7.0 based on the described method and
  the default is a sliding window of size 51.
}
\details{
The output is either a data frame or graph
  showing the calculated scores for each window along the sequence.
  The equation used was originally described in Uversky et al. (2000)\cr
  \url{https://doi.org/10.1002/1097-0134(20001115)41:3<415::AID-PROT130>3.0.CO;2-7}
  . \cr
  The FoldIndex method of using a sliding window and utilizing the Uversky
  equation is described in Prilusky, J., Felder, C. E., et al. (2005). \cr
  FoldIndex: a simple tool to predict whether a given protein sequence \cr
  is intrinsically unfolded. Bioinformatics, 21(16), 3435-3438. \cr
}
\section{Plot Colors}{

  For users who wish to keep a common aesthetic, the following colors are
  used when plotResults = TRUE. \cr
  \itemize{
  \item Dynamic line colors: \itemize{
  \item Close to -1 = "#9672E6"
  \item Close to 1 = "#D1A63F"
  \item Close to midpoint = "grey65" or "#A6A6A6"}}
}

\references{
Kyte, J., & Doolittle, R. F. (1982). A simple method for
  displaying the hydropathic character of a protein.
  Journal of molecular biology, 157(1), 105-132.
  Kozlowski, L. P. (2016). IPC – Isoelectric Point Calculator. Biology
  Direct, 11(1), 55. \url{https://doi.org/10.1186/s13062-016-0159-9} \cr
  Kyte, J., & Doolittle, R. F. (1982). A simple method for
  displaying the hydropathic character of a protein.
  Journal of molecular biology, 157(1), 105-132. \cr
  Prilusky, J., Felder, C. E., et al. (2005). \cr
  FoldIndex: a simple tool to predict whether a given protein sequence \cr
  is intrinsically unfolded. Bioinformatics, 21(16), 3435-3438. \cr
  Uversky, V. N., Gillespie, J. R., & Fink, A. L. (2000).
  Why are “natively unfolded” proteins unstructured under physiologic
  conditions?. Proteins: structure, function, and bioinformatics, 41(3),
  415-427.
  \url{https://doi.org/10.1002/1097-0134(20001115)41:3<415::AID-PROT130>3.0.CO;2-7}
}
\seealso{
\code{\link{KDNorm}} for residue hydropathy values.
  See \code{\link{pKaData}} for residue pKa values and citations. See
  \code{\link{hendersonHasselbalch}} for charge calculations.

Other scaled hydropathy functions: 
\code{\link{KDNorm}},
\code{\link{meanScaledHydropathy}()},
\code{\link{scaledHydropathyGlobal}()},
\code{\link{scaledHydropathyLocal}()}
}
\concept{scaled hydropathy functions}
