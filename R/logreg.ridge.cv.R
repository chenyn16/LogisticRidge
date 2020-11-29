#'logreg.ridge.cv
#'
#'This function logreg.ridge.cv() works to perform cross-validation to select the best lambda
#'@param y the input y as response
#'@param X the input X to fit model
#'@param lambdas a vector specifies the lambda candidates
#'@param nfolds an int sepecific how many folds you want to split the data
#'@param plot this boolean variable specifies if you want to plot the result
#'@return the function will return a list of following elements: lambda.min, the best lambda in the candidates; err the error list corresponding to the lambda vector, and lambda.vec specifies the lambda vector as input
#'@examples
#'x=matrix(rnorm(100),20,5)
#'y=sample(c(0,1),20,replace=TRUE)
#'lambdas=c(0.1,0.004,0.7,4)
#'logreg.ridge.cv(y,x,lambdas,plot=TRUE)
#'@export
#'
logreg.ridge.cv = function(y, X, lambdas, nfolds=5, plot=F){
  n = dim(X)[1]
  p = dim(X)[1]
  num.lambda = length(lambdas)

  beta.init = rep(0,p)
  cv.results = rep(0,num.lambda)

  for(i in 1:num.lambda){
    groups = rep(1:nfolds, n/nfolds)
    for( j in 1:nfolds){
      train = groups!=j
      test = groups==j
      logreg_object = logreg.ridge.fit(y[train], X[train,] , lambda = lambdas[i],
                             epochs=10,tol=1e-3)
      pred = logreg.ridge.predict(logreg_object, X[test,] ,y[test] )
      cv.results[i] = cv.results[i] + pred$err/nfolds
    }
  }
  print(cv.results)
  print(lambdas)
  if(plot){
    plot( log(lambdas) , cv.results, type='b',
             xlab='log lambda', ylab='prediction error',
             main=paste0(nfolds,"-fold CV results")
         )
  }
  lambda.min =lambdas[cv.results==min(cv.results)]

  return(list(lambda.min=lambda.min,err=cv.results,lambda.vec=lambdas))
}
