
# sparknlp

<!-- badges: start -->
<!-- badges: end -->

R [sparklyr](https://sparklyr.ai/) extension for using [John Snow Labs](https://www.johnsnowlabs.com/) 
[Spark NLP](https://www.johnsnowlabs.com/spark-nlp) library.

# Installation
Install from this Github repository using:

## Most recent release
```
remotes::install_github("r-spark/sparknlp")
```

## Specific version
```
remotes::install_github("r-spark/sparknlp@v0.2.0")
```

## Bleeding edge in development version
```
remotes::install_github("r-spark/sparknlp@dev")
```

# Unimplemented features
The following features/annotators have not been implemented yet

## Spark NLP
* AlbertForSequenceClassification
* AnnotationMerger
* BertForSequenceClassification
* CamemBertEmbeddings
* DeBertaEmbeddings
* DeBertaForSequenceClassification
* DeBertaForTokenClassification
* DistilBertForSequenceClassification
* Doc2Vec
* GPT2Transformer
* LongformerForSequenceClassification
* MedicalBertForTokenClassification
* RoBertaForSequenceClassification
* XlmRoBertaForSequenceClassification
* XlnetForSequenceClassification
* WordSegmenter

## Spark NLP for Healthcare
* AnnotationMerger
* ChunkKeyPhraseExtraction
* ChunkMapperApproach
* ChunkSentenceSplitter
* DeIdentification
* EntityChunkEmbeddings
* MedicalBertForSequenceClassification
* MedicalBertForTokenClassifier
* MedicalDistilBertForSequenceClassification
* StructuredDeIdentification
* TFGraphBuilder
* ZeroShotRelationExtraction

# Usage
There are a lot of examples in R notebooks inside the `examples` directory. I recommended starting with the 
notebooks in [tutorials/certification_trainings](https://github.com/r-spark/sparknlp/tree/master/examples/tutorials/certification_trainings).

The `examples` directory structure here follows the notebook examples found at
[spark-nlp-workshop](https://github.com/JohnSnowLabs/spark-nlp-workshop).
Note that not all the Jupyter notebooks found there have been ported yet, but all functionality still exists in the 
package.

## Spark NLP version
The package has a default Spark NLP version that will be used when a Spark Session 
is created with `spark_connect`. This is usually the latest version. 

### Default Spark NLP versions

| R package version | Default Spark NLP version |
|-------------------|-------------------|
| 0.2.x | 3.0.1 |
| 0.3.x | 3.0.2 |
| 0.5.x | 3.0.3 |
| 0.6.x | 3.1.0 |
| 0.7.x | 3.1.1 |
| 0.8.x | 3.1.2 |
| 0.9.x | 3.3.0 |
| 0.10.x | 3.3.1 |
| 0.11.x | 3.3.4 |
| 0.12.x | 3.4.0 |
| 0.13.x | 3.4.1 |
| 0.14.x | 3.4.2 |
| 0.15.x | 3.4.4 |
| 0.16.x | 4.2.0 |

The function `nlp_version()`
will show you the version that will be used. If you wish to change the version call 
the function `set_nlp_version()` before connecting to Spark. This will only change the
version of the Spark NLP jar that is loaded by Spark. There could be some code changes
that won't work with older versions of the library. If that happens, the best thing to
do would be to use an older version of this package.

*Note: the version used when the licensed healthcare library is enabled is determined
separately based on the secret code provided by John Snow Labs. See the section Licensed
models and annotators below for more information.*

## GPU usage
John Snow Labs does provide GPU enabled versions of the library jars. If you would like
to use these jars set the environment variable `SPARK_NLP_GPU` to "TRUE". If this 
is not set or is set to something that R doesn't treat as TRUE using `as.logical` then
the regular CPU library will be used.

## Licensed models and annotators
If you have purchased a license to the licensed models and annotators, first follow the 
normal steps in [Spark NLP for Healthcare Getting Started](https://nlp.johnsnowlabs.com/docs/en/licensed_install#install-spark-nlp-for-healthcare).

Once you've done this you should have your AWS-CLI credentials setup and can use the 
licensed pretrained models in the unlicensed annotators (such as ner_dl).

In order to use the licensed annotators you must also setup the environment variable
SPARK_NLP_SECRET_CODE with the secret code provided by John Snow Labs with your
license and SPARK_NLP_LICENSE with the license key.
