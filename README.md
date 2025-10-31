# ph-titanic-regression
The goal of this repository is to create a logistic regression model in python and r based on the titantic training data, then predict the survival rate of the titanic test set.
Included in this repository are Dockerfiles for both applications.

## Files and Directories in this Repository
Dockerfile - dockerfile to build the titanic-regression python application
Dockerfile.r - dockerfile to build the titanic_regression R application
requirements.txt - python package requirements
src - source directory with all application code and prediction files
run - directory for the python regression application code
run-r - directory for the r regression application code
titanic-regression.py - application code using the logistic regression model to predict the survival of the titantic passengers in the test set
test_set_predictions.csv - python model prediction output on the test set
install_packages.R - r package requirements
titanic_regression.R - application code using the logistic regression model to predict the survival of the titantic passengers in the test set
test_set_predictions_r.csv - R model prediction output on the test set


## Using the repository
### Getting the data
The current application setup assumes that there is a directory called "data" within src that contains the files train.csv and test.csv. To acquire the data, go to 
https://www.kaggle.com/competitions/titanic/data and download the linked zip file, then create the data directory within the src folder. Unzip the data, and the apps
will run with no alterations needed. If you would like to change the location of the data folder, it can be anywhere inside of the repository, but the pd.read_csv and
read_csv lines in titanic-regression.py and titanic_regression.r will need to be updated.

### Running the applications
To build the python application, run docker build -t titanic . within the ph-titantic-regression directory
This will build a Docker image called titanic, which can be run by calling docker run --rm titanic
The application will print to the terminal the data cleaning steps taken, the accuracy of the slim and full logistic regression model on the training set, and save the
results of the model predictions on the test set to a file called test_set_predictions.csv

To build the r application, run docker build -f Dockerfile.r -t titanic-r . within the ph-titanic-regression directory
This will build a Docker image called titanic-r, which can be run by calling docker run --rm titanic-r
The application will print to the terminal the data cleaning steps taken, the accuracy of the slim and full logistic regression model on the training set, and save the
results of the model predictions on the test set to a file called test_set_predictions_r.csv

