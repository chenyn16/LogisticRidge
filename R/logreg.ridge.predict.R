#'logreg.ridge.predict
#'This function works as prediction and possible return classification error
#'@param logreg_object this is the object obtained from running fit.logreg.ridge() function
#'@param X.new this is the matrix data we want to compute.
#'@param y.new this is optional y. If a y.new is specified, then the function will use it to compute error.
#'@return it will return a list object with three elements: y.hat the predicted score, pred the predicted class, err if y is pecified then this is the error, otherwise its 'None'
#'
#'@examples
#'x=matrix(rnorm(100),20,5)
#'y=sample(c(0,1),20,replace=TRUE)
#'logreg_object = logreg.ridge.fit(y,x,lambda=0)
#'X_new = x
#'logreg.ridge.predict( logreg_object, X_new, y )
#'@export

logreg.ridge.predict = function(logreg_object, X.new, y.new='None'){

  beta = logreg_object[['coefficients']]
  if(y.new[1] =='None'){
    class.err='None'
    n = dim(X.new)[1]
    eta.hat = X.new %*% beta
    y.hat = c(exp(eta.hat) / (1+exp(eta.hat)))
    pred = as.numeric(y.hat>0.5)
  }else{
    n = length(y.new)
    eta.hat = X.new %*% beta
    y.hat = c( exp(eta.hat) ) / (1+exp(eta.hat))
    pred = as.numeric(y.hat>0.5)
    class.err = 1-sum(pred==y.new)/n
  }
  return( list(y.hat=y.hat, pred=pred, err=class.err) )

}
