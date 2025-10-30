# titanic_regression.r
# Train and run a logistic regression model 
# on Titanic survival data and compare the
# accuracy on the training and test set data

# Author: Pippa Hodgkins
# Created: October 2025
# Updated: 10/29/25

library(performance)

# helper function to clean up missing age values in the given dataframe
data_cleaning = function(df) {
  print("We need to convert sex to a numeric feature to use in the regression")
  df['Sex'] = ifelse(df['Sex'] == "female", 1, 0)
  #df['Sex'][df['Sex'] == "male"] = 0
  #df['Sex'][df['Sex'] == "female"] = 1
  
  print("we're going to fill the missing ages with the mean from their gender and class")
  for (i in 1:3) {
    for (j in 0:1) {
      avg_age = mean(df['Age'][(df['Pclass'] == i) & (df['Sex'] == j)], na.rm=TRUE)
      (df['Age'][(df['Pclass'] == i) & (df['Sex'] == j) & (is.na(df$Age))]
       = avg_age)
    }
  }
  df
}

# main script
print("import the training data")
training_ship = read.csv("../data/train.csv")

print("exploring the data")
print(summary(training_ship))
print("\n")

print("we see a few records with a missing age")
training_ship = data_cleaning(training_ship)

print("\nwe're going to fit two models with slightly different feature sets")

slim_model = glm(Survived ~ Pclass + Sex + Age, data=training_ship, family = "binomial")
full_model = glm(Survived ~ Pclass + Sex + Age + SibSp + Parch, data=training_ship, family = "binomial")

print("Summary of the slim model")
print(summary(slim_model))

print("Summary of the full model")
print(summary(full_model))

print("Accuracy of the slim model:")
print(performance_accuracy(slim_model))
print("Accuracy of the full model:")
performance_accuracy(full_model)

print("The full model with features Pclass, Sex, Age, SibSp, and Parch has the better accuracy")

test_ship = read.csv("../data/test.csv")
test_ship = data_cleaning(test_ship)

full_test_predictions = predict(full_model, test_ship, type="response")
print("Map test set predictions to 0 (Died) and 1 (Survived)")
full_test_predictions$Survived = ifelse(full_test_predictions >= 0.5, 1, 0)
full_test_predictions$PassengerId = test_ship$PassengerId

print("Test set predictions found in test_set_predictions.csv")
write.csv(full_test_predictions[c('Survived', 'PassengerId')], "test_set_predictions_r.csv")
