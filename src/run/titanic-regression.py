'''
titanic_regression.py
Train and run a logistic regression model 
on Titanic survival data and compare the
accuracy on the training and test set data

Author: Pippa Hodgkins
Created: October 2025
Updated: 10/26/25
'''

# import required packages
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
import sklearn.metrics as skl_met
import sklearn as skl
import os
import sys

def data_cleaning(df):
    '''helper function to clean up missing age values in the given dataframe'''

    print("We need to convert sex to a numeric feature to use in the regression")
    df['Sex'] = df['Sex'].map({'male' : 0, 'female': 1})


    print("we're going to fill the missing ages with the mean from their gender and class")
    for i in range(1,4):
        for j in range(0,2):
            df.loc[((
                df['Pclass'] == i) & (df['Sex'] == j
            )), 'Age'] = (
            np.mean(df['Age'].loc[((
                df['Pclass'] == i) &
                (df['Sex'] == j
            ))]))



def main():
    script_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
    print(script_directory)
    
    print("import the training data")
    training_ship = pd.read_csv("../data/train.csv")

    print("exploring the data")
    print(training_ship.info())
    print("\n")

    print("we see a few records with a missing age")
    data_cleaning(training_ship)

    print("\nwe're going to fit two models with slightly different feature sets")

    # fit the model
    slim_model = LogisticRegression(max_iter=1000)
    full_model = LogisticRegression(max_iter=1000)

    slim_features = ['Pclass', 'Sex', 'Age']
    full_features = ['Pclass', 'Sex', 'Age', 'SibSp', 'Parch']

    print("Slim model features: ", slim_features)
    print("Full model features: ", full_features)

    slim_model.fit(training_ship[slim_features], training_ship['Survived'])
    full_model.fit(training_ship[full_features], training_ship['Survived'])

    slim_train_predictions = slim_model.predict(training_ship[slim_features])
    full_train_predictions = full_model.predict(training_ship[full_features])

    print("Slim Model Accuracy: ", skl.metrics.accuracy_score(slim_train_predictions, training_ship['Survived']))
    print("Full Model Accuracy: ", skl.metrics.accuracy_score(full_train_predictions, training_ship['Survived']))

    print("The full model with features: ", full_features, "has the higher accuracy\n")

    print("Running the full model on the test set")
    test_ship = pd.read_csv('../data/test.csv')

    data_cleaning(test_ship)

    full_test_predictions = full_model.predict(test_ship[full_features])

    test_predictions_df = pd.DataFrame(test_ship['PassengerId'])
    test_predictions_df['Predictions'] = full_test_predictions

    print("Test set predictions found in test_set_predictions.csv")
    test_predictions_df.to_csv("test_set_predictions")


if __name__=="__main__":
    main()