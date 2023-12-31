#' Sequence Check Function
#'
#' This is used validate a sequence of amino acids.
#'   It can additionally be used to load an amino acid sequence.
#'   It can also be used to coerce a sequence into a specific format.
#' @param sequence amino acid sequence as a single character string,
#'   a vector of single characters, or an AAString object.
#'   It also supports a single character string that specifies
#'   the path to a .fasta or .fa file.
#' @param method Required Setting.
#'   \code{method = c("stop", "warn")}. "stop" by default.
#'   "stop" Reports invalid residues as an error and
#'   prevents the function from continuing.
#'   "warn" Reports invalid residues through a warning
#'   Any invalid sequences will be reported as intended.
#' @param outputType Required Setting. "string" By default.
#'   \code{outputType = c("string", "vector", "none")}
#'   "string" returns the sequence as a single string of amino acids.
#'   "vector" returns the sequence as a vector of individual characters.
#'   "none" prevents the function from returning a sequence.
#' @param nonstandardResidues Optional setting.
#'   Expands the amino acid alphabet.
#'   NA or Character vector required.
#'   Default values are "ACDEFGHIKLMNPQRSTVWY". Additional letters added here.
#'   \code{nonstandardResidues = c("O,U")}
#'   to allow Pyrrolysine (O) and Selenocysteine (U).
#' @param suppressAAWarning If using nonstandardResidues,
#'    a warning will be issued.
#'   set \code{nonstandardResidues = T}
#'   to confirm addition of non-standard residues.
#' @param suppressOutputMessage Set \code{suppressOutputMessage = T}
#'   to prevent sequence validity message
#'
#' @return A message and sequence are returned.
#'   If \code{suppressOutputMessage = T}, the message is not returned.
#'   If \code{outputType = "None")}, the sequence is not returned.
#'   Otherwise, outputType will determine the format of the returned sequence.
#'   If the sequence contains an error, it will be reported
#'   based on the value of method.
#'   The Sequence will be assigned to the value "Sequence" if sequenceName
#'   is not specified. Otherwise the sequence is assigned to the value of
#'   sequenceName. This allows the sequences to be called by the user.
#' @export
#' @importFrom methods is
#' @examples
#' #Amino acid sequences can be character strings
#' aaString <- "ACDEFGHIKLMNPQRSTVWY"
#' #Amino acid sequences can also be character vectors
#' aaVector <- c("A", "C", "D", "E", "F",
#'            "G", "H", "I", "K", "L",
#'            "M", "N", "P", "Q", "R",
#'            "S", "T", "V", "W", "Y")
#' #Alternatively, .fasta files can also be used by providing
#' ##The path to the file as a character string
#' \dontrun{
#' sequenceCheck(aaString)
#' sequenceCheck(aaVector)
#'
#'
#' #To allow O and U
#' sequenceCheck(aaString,
#'            nonstandardResidues = c("O", "U"),
#'            suppressAAWarning = TRUE)
#'
#' #To turn off output message
#' sequenceCheck(aaString,
#'            suppressOutputMessage = TRUE)
#'
#' #To change string to be a vector
#' sequenceCheck(aaString,
#'            outputType = "vector")
#'
#' #To not return a sequence but check the input
#' sequenceCheck(aaVector,
#'             outputType = "none")
#' }
#'

sequenceCheck <- function(
    sequence,
    method = "stop",
    outputType = "string",
    nonstandardResidues = NA,
    suppressAAWarning = FALSE,
    suppressOutputMessage = FALSE) {
    if (!all(is.character(outputType), is.character(method))) {
        stop("Error: method and outputType must be character vectors,")
    }
    if (!any(is.character(sequence),
             (is(sequence)[1] %in% c("AAString", "BString",
                                      "AAStringSet", "BStringSet"))
             )) {
        stop("Error: sequence must be a character vector or an AAString Object")
    }
    if (!(method %in% c("stop", "warn"))) {
        stop('Error: method is not equal to a valid term.
            Set method equal to "stop" or "warn"')
    }
    #-----
    #This section will confirm what to do with the amino acid sequence
    if (is(sequence)[1] %in% c("AAString", "BString",
                              "AAStringSet", "BStringSet")) {
        sequence <- as.character(sequence)
    }
    if (length(sequence) == 1) {
        #this is to see if the string is a .fasta / .fa file
        if (grepl("\\.fa", sequence, ignore.case = TRUE)) {
        sequence <- Biostrings::readAAStringSet(sequence, format = "fasta")
        sequence <- as.character(sequence)
        }
        separatedSequence <- strsplit(sequence, "")
        names(separatedSequence) <- NULL
        separatedSequence <- unlist(separatedSequence)
    } else {
        separatedSequence <- sequence
    }
    #----- Test for valid residues
    aa <- "ACDEFGHIKLMNPQRSTVWY"
    aa <- strsplit(aa, "")
    aa <- unlist(aa)
    if (!is.na(nonstandardResidues)) {
        aa <- c(aa, nonstandardResidues)
        if (!suppressAAWarning) {
            warningMessage <- paste(
            "This validation allows the following non-standard amino acids: ",
                nonstandardResidues,
                ". If this is an error, please set nonstandardResidues = NA . ",
                "If this is not an error, please set suppressAAWarning = T. ",
                sep = "")
            warning(warningMessage)
        }
    }
    #-----
    #This section checks if the amino acid sequence contains invalid residues
    aaError <- FALSE
    #Used for returning messages later. Set to False unless there is an error
    if (all(separatedSequence %in% aa) == FALSE) {
        aaError <- TRUE #Used for returning messages later reporting an error
        invalidResidues <- separatedSequence[!(separatedSequence %in% aa)]
        invalidResidues <- unique(invalidResidues)
        warningMessage <- paste(
                            "Protein contains the following invalid residues: ",
                            invalidResidues, ". ", sep = "", collapse = "")
        #--- below reports the error
        if (method == "stop") {
            stop(warningMessage)
        } else {
            warning(warningMessage)
        }
        #--- below reports the error
    }
    #------
    #this section creates the output
    if (outputType == "string") {
        outputSequence <- paste(separatedSequence, sep = "", collapse = "")
    }
    if (outputType == "vector") {
        outputSequence <- separatedSequence
    }
    if (suppressOutputMessage == FALSE) {
        if (aaError == FALSE) {
            validMessage <- paste("The sequence contains no invalid residues.")
        }
        if (aaError == TRUE) {
            validMessage <-
                paste("INVALID SEQUENCE! There are invalid residues.")
        }
        message(validMessage)
    }
    if (!outputType == "none") {
        return(outputSequence)
    }
}
