# LogisticRidge
This little package is made for logistic regression with ridge penalty. It has three functions to be used, they are logreg.ridge.fit, logreg.ridge.predict, and logreg.ridge.cv. They will be used to fit a model, predict new data from a model, and perform cross-validation to find the best choice of lambda.

# Functions
#### logreg.ridge.fit(y , X, lambda, epochs, tol, beta0)
This function takes input of prediction label y (a vector of 0 and 1), predictors matrix X, a value of lambda, number of training iterations, tol to determine early stop and a beta0 to determine the initiali beta. This function will train a logistic regression with the given lambda value.

#### logreg.ridge.predict(logreg_obect, X.new, y.new) 
This function takes input of an object computed from logreg.ridge.fit() function, X.new as the new data. If there's no y.new to compare results, user can ignore this input as it will automatically be read as 'None'. It will predict from the X.new data, and if y.new is provided, it will compare the result.

#### logreg.ridge.cv(y, X, lambdas, nfolds, plot)
This function takes input of y, X, a vector of candidate lambdas, number of folds to perform cross-validation, and whether to plot the result. This function will perform cross-validation on the given y, and X.
