package sparknlp

import com.johnsnowlabs.nlp.annotators.classifier.dl.ClassifierDLApproach
import com.johnsnowlabs.nlp.annotators.ner.dl.NerDLApproach
import com.johnsnowlabs.nlp.RecursivePipeline
import com.johnsnowlabs.nlp.pretrained.PretrainedPipeline
import com.johnsnowlabs.nlp.LightPipeline
import com.johnsnowlabs.nlp.JavaAnnotation
import org.apache.spark.ml._
import collection.JavaConverters._

object Utils {
  def setNerLrParam(nerDLApproach: NerDLApproach, lr: Double) : NerDLApproach = {
    nerDLApproach.setLr(lr.toFloat)
  }
  
  def setNerPoParam(nerDLApproach: NerDLApproach, po: Double) : NerDLApproach = {
    nerDLApproach.setPo(po.toFloat)
  }
  
  def setNerDropoutParam(nerDLApproach: NerDLApproach, dropout: Double) : NerDLApproach = {
    nerDLApproach.setDropout(dropout.toFloat)  
  }
  
  def setCDLLrParam(classifierDLApproach: ClassifierDLApproach, lr: Double) : ClassifierDLApproach = {
    classifierDLApproach.setLr(lr.toFloat)
  }

  def setCDLDropoutParam(classifierDLApproach: ClassifierDLApproach, dropout: Double) : ClassifierDLApproach = {
    classifierDLApproach.setDropout(dropout.toFloat)  
  }

  def setCDLValidationSplitParam(classifierDLApproach: ClassifierDLApproach, validation_split: Double) : ClassifierDLApproach = {
    classifierDLApproach.setValidationSplit(validation_split.toFloat)
  }
  
  def createRecursivePipelineFromStages(uid: String, stages: PipelineStage*): RecursivePipeline = {
    new RecursivePipeline(uid)
      .setStages(stages.toArray)
  }
  
  def pretrainedPipeline(downloadName: String, lang: String, source: String, parseEmbeddingsVectors: Boolean, 
                         diskLocation: String): PretrainedPipeline = {
    var diskLocationOpt = None: Option[String]
    
    if (diskLocation != null) {
     diskLocationOpt = Some(diskLocation)
    }
                           
    new PretrainedPipeline(downloadName, lang, source, parseEmbeddingsVectors, diskLocationOpt);
  }
  
  def annotateList(lp: LightPipeline, target: Array[String]): java.util.List[java.util.Map[String, java.util.List[String]]] = {
    val targetList: java.util.ArrayList[String] = new java.util.ArrayList[String](target.toList.asJava)
    lp.annotateJava(targetList)
  }
  
  def fullAnnotateList(lp: LightPipeline, target: Array[String]): java.util.List[java.util.Map[String, java.util.List[JavaAnnotation]]] = {
    val targetList: java.util.ArrayList[String] = new java.util.ArrayList[String](target.toList.asJava)
    lp.fullAnnotateJava(targetList)
  }
  
  def setStoragePath(obj: com.johnsnowlabs.nlp.embeddings.WordEmbeddings, path: String, format: String): Object = {
    obj.setStoragePath(path, com.johnsnowlabs.nlp.util.io.ReadAs.withName(format))
  }
}