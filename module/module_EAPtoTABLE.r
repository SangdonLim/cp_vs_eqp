# module/module_EAPtoTABLE.r
# function for converting EAP estimates into a table

EAPtoTABLE <- function(EAP, dimension, tscore) {

  eap  <- lapply(EAP, function(x) x$EAP[dimension])
  se   <- lapply(EAP, function(x) sqrt(x$COV[dimension, dimension]))
  eap  <- do.call(c, eap)
  se   <- do.call(c, se)
  if (tscore) {
    eap <- (eap*10) + 50
    se  <- se*10
  }
  x <- as.numeric(names(eap))
  o <- cbind(x, eap, se)
  o <- as.data.frame(o)

  return(o)

}
