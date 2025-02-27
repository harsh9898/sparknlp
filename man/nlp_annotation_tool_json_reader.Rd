% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/annotation_tool_json_reader.R
\name{nlp_annotation_tool_json_reader}
\alias{nlp_annotation_tool_json_reader}
\title{Spark NLP AnnotationToolJsonReader}
\usage{
nlp_annotation_tool_json_reader(
  sc,
  assertion_labels = list(),
  excluded_labels = list(),
  cleanup_mode = "disabled",
  split_chars = list(),
  context_chars = list(),
  scheme = "IOB",
  min_chars_tol = 2L,
  align_chars_tol = 1L,
  merge_overlapping = TRUE,
  sddl_path = ""
)
}
\arguments{
\item{assertion_labels}{list of strings}

\item{excluded_labels}{list of strings}

\item{cleanup_mode}{string (Default: disabled)}

\item{split_chars}{list of strings}

\item{context_chars}{list of strings}

\item{scheme}{string (Default: "IOB")}

\item{min_chars_tol}{integer (Default: 2)}

\item{align_chars_tol}{integer (Default: 1)}

\item{merge_overlapping}{boolean (Default: true)}

\item{sddl_path}{string (Default: "")}
}
\value{
assertion train set
}
\description{
The annotation tool json reader is a reader that generate a assertion train set from the json from annotations labs exports.
}
