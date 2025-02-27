#' Spark NLP NerConverter
#'
#' Spark ML transformer that converts IOB or IOB2 representation of NER to user-friendly. 
#' 
#' @template roxlate-nlp-transformer
#' @template roxlate-inputs-output-params
#' @param preserve_position Whether to preserve the original position of the tokens 
#' in the original document or use the modified tokens
#' @param white_list If defined, list of entities to process. The rest will be ignored.
#'  Do not include IOB prefix on labels"
#' @param lazy_annotator allows annotators to stand idle in the Pipeline and do nothing.
#'  Can be called by other Annotators in a RecursivePipeline
#' 
#' @return When \code{x} is a \code{spark_connection} the function returns a NerConverter transformer.
#' When \code{x} is a \code{ml_pipeline} the pipeline with the NerConverter added. When \code{x}
#' is a \code{tbl_spark} a transformed \code{tbl_spark}  (note that the Dataframe passed in must have the input_cols specified).
#' 
#' @export
nlp_ner_converter <- function(x, input_cols, output_col,
                 white_list = NULL, preserve_position = NULL, lazy_annotator = NULL,
                 uid = random_string("ner_converter_")) {
  UseMethod("nlp_ner_converter")
}

#' @export
nlp_ner_converter.spark_connection <- function(x, input_cols, output_col,
                 white_list = NULL, preserve_position = NULL, lazy_annotator = NULL,
                 uid = random_string("ner_converter_")) {
  args <- list(
    input_cols = input_cols,
    output_col = output_col,
    preserve_position = preserve_position,
    white_list = white_list,
    lazy_annotator = lazy_annotator,
    uid = uid
  ) %>%
  validator_nlp_ner_converter()

  jobj <- sparklyr::spark_pipeline_stage(
    x, "com.johnsnowlabs.nlp.annotators.ner.NerConverter",
    input_cols = args[["input_cols"]],
    output_col = args[["output_col"]],
    uid = args[["uid"]]
  ) %>%
    sparklyr::jobj_set_param("setWhiteList", args[["white_list"]]) %>% 
    sparklyr::jobj_set_param("setPreservePosition", args[["preserve_position"]]) %>% 
    sparklyr::jobj_set_param("setLazyAnnotator", args[["lazy_annotator"]])

  new_nlp_ner_converter(jobj)
}

#' @export
nlp_ner_converter.ml_pipeline <- function(x, input_cols, output_col,
                 white_list = NULL, preserve_position = NULL, lazy_annotator = NULL,
                 uid = random_string("ner_converter_")) {

  stage <- nlp_ner_converter.spark_connection(
    x = sparklyr::spark_connection(x),
    input_cols = input_cols,
    output_col = output_col,
    white_list = white_list,
    preserve_position = preserve_position,
    lazy_annotator = lazy_annotator,
    uid = uid
  )

  sparklyr::ml_add_stage(x, stage)
}

#' @export
nlp_ner_converter.tbl_spark <- function(x, input_cols, output_col,
                 white_list = NULL, preserve_position = NULL, lazy_annotator = NULL,
                 uid = random_string("ner_converter_")) {
  stage <- nlp_ner_converter.spark_connection(
    x = sparklyr::spark_connection(x),
    input_cols = input_cols,
    output_col = output_col,
    white_list = white_list,
    preserve_position = preserve_position,
    lazy_annotator = lazy_annotator,
    uid = uid
  )

  stage %>% sparklyr::ml_transform(x)
}
#' @import forge
validator_nlp_ner_converter <- function(args) {
  args[["input_cols"]] <- cast_string_list(args[["input_cols"]])
  args[["output_col"]] <- cast_string(args[["output_col"]])
  args[["white_list"]] <- cast_nullable_string_list(args[["white_list"]])
  args[["preserve_position"]] <- cast_nullable_logical(args[["preserve_position"]])
  args[["lazy_annotator"]] <- cast_nullable_logical(args[["lazy_annotator"]])
  args
}

new_nlp_ner_converter <- function(jobj) {
  sparklyr::new_ml_transformer(jobj, class = "nlp_ner_converter")
}
