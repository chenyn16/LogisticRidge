# LogisticRidge
This little package is made for logistic regression with ridge penalty. It has three functions to be used, they are logreg.ridge.fit, logreg.ridge.predict, and logreg.ridge.cv. They will be used to fit a model, predict new data from a model, and perform cross-validation to find the best choice of lambda.

# Functions
#### logreg.ridge.fit(y , X, lambda, epochs, tol, beta0)
This function takes input of prediction label y (a vector of 0 and 1), predictors matrix X, a value of lambda, number of training iterations, tol to determine early stop and a beta0 to determine the initiali beta.
