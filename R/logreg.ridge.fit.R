#'logreg.ridge.fit
#'
#'This function takes y,x and lambda to perform a logistic regression w/wo l2 penalty
#'The input data should be a numeric matrix without factoer level, though we can use the transform method to encode it.
#'This function will return a list including coefficients of estimates, yhat, and predicted class, and classification error
#'@param y input y, this is the label of the class, it should be a vector of either zero or one
#'@param X input X, this is a matrix of training X.
#'@param lambda the coefficient of how severe the penalty should be
#'@param epochs this value specifies how much iteration will we do to update our coefficients
#'@param tol this input means tolerance, which determines early stop in training
#'@param beta0 this is the initialization of beta estimators, sometimes user may want to further train a specific beta, and they can use it as input.
#'@return it will return a list of estimated coefficients, the predicted score y.hat, the predicted class yhat and classification error.
#'@examples
#'x=matrix(rnorm(100),20,5)
#'y=sample(c(0,1),20,replace=TRUE)
#'logreg.ridge.fit(y,x,lambda=0)
#'@export


logreg.ridge.fit = function(y, X, lambda, epochs=10,
                           tol=1e-5, beta0 = rep(0,dim(X)[2])){
  ####################
  #initialization
  ####################
  beta.old = beta0 #initiliaze beta
  n = dim(X)[1]
  p = dim(X)[2]

  #Newton-Raphson
  for(k in 1:epochs){
    eta.hat = X %*% beta.old
    y.hat = c(exp(eta.hat) / (1+exp(eta.hat))  )
    w = pmax(y.hat*(1-y.hat) , 1e-10)  #numerical tolerance

    X.tilde = sqrt(w)*X
    y.tilde = eta.hat * w + (y-y.hat)
    beta.new = c(solve(crossprod(X.tilde) +lambda*diag(c(0,rep(1,p-1))) ,
                       crossprod(X,y.tilde)))

    if(max(abs(beta.new-beta.old)) < tol){ #no more updates
      break
    }
    beta.old=beta.new
  }

  eta.hat = X %*% beta.old
  y.hat = c(exp(eta.hat) /(1+exp(eta.hat))  )
  pred = as.numeric(y.hat > 0.5)
  class.err = 1-sum(pred==y)/n

  return( list(coefficients=beta.new , y.hat=y.hat, pred=pred, err=class.err) )
}
