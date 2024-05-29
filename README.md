The task:

A common market research or business analytics task is to build a sales model,
also called a “marketing mix model” (MMM). For this coursework, imagine that the
manufacturer of a fast-moving consumer goods (FMCG) brand hires you as an analyst and
its profit relies on the sale of large volumes of their product, as from each unit sold the
profit is only 30%. The brand wants to know how many additional sales are associated with
the three marketing activities: TV advertisements, online banner advertisements, and sale
promotions at distribution stores. They have collected 5 years of monthly sales data for their
product, as well as the average retail prices and the necessary advertising data, split
separately into their 5 international markets. Specifically, they ask you to find the answers
from the data for the following questions:
- How many units sold are associated with each of the three marketing activities?
- Our TV ads cost us £2,000,000 a year and our Banners £500,000 a year (in total for all
regions). Which one is more cost-effective?
- Our sales often show a lot of variation. Can you explain to us possible sources of the
variation, other than the marketing activities?
- Could you provide a prediction of the sales of the next month for all countries/regions?

QUANTITATIVE METHODOLOGY PIPELINE USED
1. Changing the names of the Columns to make them easier to use: This was done to change the
complex names of the columns to a more straightforward form that can be used with ease. In R,
the names () function was used for this, in which new names for the columns were passed as
vectors.
2. Deleting the null values: Null values can cause skewness in data, which may translate into building
the wrong model. To remove the null values, the R function na.omit() was used to delete rows with
null values in the dataset.
3. Applying Box-Cox transformation: As the Sales data given had high heteroscedasticity (varying
levels of variance), resulting in high skewness and a non-normal distribution of the Sales data. To
address this, the Box-Cox data transformation technique was used. This method stabilizes the
variance through a series of power transformations to bring the dataset closer to a normal
distribution.
4. Breaking the dataset into the test and train sets: This is a common practice in supervised learning
models in data science, where the original data is bifurcated into two or three sets. The first set is
used to build models, and the others are used to check the robustness and correctness of the
model. For this, a sample () function (80: 20 split) in R was used to create two datasets, train_set
and test_set, with the seed set to 123.
MANAGERIAL SUMMARY OF RESULTS
1. Sales are significantly impacted by marketing campaigns like promotions and banner
advertisements. For example, an increase of one unit in online banner ads is linked to an
anticipated rise in sales of 8,000 units, and in a similar vein, an increase of one unit in distribution
store sales promotions is linked to an expected increase in sales of 500 units. However, there is
an inverse correlation between the sales data and the TV advertising, suggesting that the TV
marketing efforts need to be revised. As a result, FruitTea may maximize profits through careful
resource management. (Figure 1)
2. The cost per unit sold for TV ads is extremely high or undefined, hence banners would be
considered more cost-effective. Infact, banners would be the most effective and will contribute 16
times more than the store promotions for Sales. (Figure 2)
Figure 2: Contribution of marketing campaign to
sales
Figure 1: Increase in Sales per unit increase in different
marketing campaigns
3. Marketing is not the only factor that affects sales. By including more independent factors that might
affect sales in addition to the ones used to develop the model, the model may still be improved, as
shown by the Adjusted R2 of 87%. For instance, inconsistent product availability on the market may
result from supply chain interruptions or inefficiencies. Or difficulties with distribution or delays in
obtaining essential materials may affect sales. Variations in customer preferences directly affect
the demand for a product. Increased knowledge of natural ingredients and the trend toward
healthier beverage alternatives, as previously indicated, may have an impact on sales. Sales are
very susceptible to the effects of competitive pressures, such as the availability of replacements or
other alternatives. In this instance, fruit tea is found to be competitive with traditional tea.
4. Linear Regression is the prediction model that is used to forecast sales for the upcoming month
i.e., Jan 2015 across the regions. (Figure 3)

TECHNICAL AND DETAILED EXPLANATION OF RESULTS
1. Interpretation for units sold associated with each Parameter (Coefficients):
a. TV advertisements (Ad1mod) Coefficient - 3.018 X 10-11
- Sales fluctuate imperceptible for
every unit rise in TV advertisements. Additionally, the extremely small coefficient raises
questions about its practical significance in influencing sales.
b. Online banner advertisements (Ad2) Coefficient - 8.568 X 103
- An increase in Ad2 of one
unit is predicted to result in a corresponding rise in sales of about 8000 units.
c. Promotions at distribution stores (Prom) Coefficient - 5.030 X 102
- It means that an increase
in promotional activities (Prom) of one unit is linked to an anticipated rise in sales of around
500 units.
d. Wage coefficient - 1.654 - An increase in wages for one unit is projected to correspond with
a sales rise of around 1.654 units.
e. Each region has a different coefficient that shows how sales have changed from the
reference region.
2. Error Percentage: A tiny residual standard error of less than 0.38% shows that the projected values
do not significantly differ from the actual observed values, meaning that the model can be used to
project future sales based on an alternative marketing strategy that the firm may implement.
3. Model Accuracy: A high R2 and Adjusted R2 value of 87% show that the independent variables in
the linear model (TV commercials, online banner advertising, store promotions, wage coefficients,
and region) can account for 87% of the variability in the dependent variable (sales).
4. Low P-Value: A low p-value of 2.2 x 10-16 means that there is a relationship between the
independent variables (linear regression parameters) and the dependent variable (sales), which
means the null hypothesis is rejected. Furthermore, the p-value is less than the usual significance
level of 0.05, which should be highlighted.
5. Large F-statistics: A low p-value and a large F statistics value of 199.5 indicate that the null
hypothesis is rejected and that the model is statistically significant.
<img width="458" alt="image" src="https://github.com/HuzaibShafi/market_Strategy/assets/17618846/a087fe98-ee5d-4d0c-8e6c-0a686bae7f96">

The model's fit and performance were assessed using standard metrics, including Mean Squared Error
(MSE), Root Mean Squared Error (RMSE), and Mean Absolute Error (MAE).
The values of MSE (0.1781369), RMSE (0.4220627), and MAE (0.3431796) indicate that the model has a
good fit to the data, with low average errors in predicting sales.
● Scatter Plot of Predicted vs. Actual Values (Linearity)
<img width="468" alt="image" src="https://github.com/HuzaibShafi/market_Strategy/assets/17618846/209616a4-6adc-4b8b-a686-6d8c61fdf29c">

Figure 5: Predicted vs. Actual Values (Training set)
When most points fall on and around the line in a predicted vs. actual values plot for a training set, it
indicates that the model has achieved a good fit for the training data. The close alignment between
predicted and actual values suggests high accuracy showing low values of Mean Squared error, low
residuals, and reliability in capturing the underlying patterns in the data.
● Residuals vs. Fitted Plot: (Homoscedasticity)
<img width="412" alt="image" src="https://github.com/HuzaibShafi/market_Strategy/assets/17618846/621837d9-b22f-4d44-8c2b-99375df55dde">
Figure 6: Residuals vs Fitted
A random scatter of residuals around the zero line in a Residuals vs. Fitted Plot suggests that the model's
predictions are unbiased and that it adequately captures the variability in the data. It suggests
homoscedasticity, meaning that the variance of residuals is relatively constant across all levels of the
independent variable(s).
● QQ Plot of Residuals (Normality)
<img width="408" alt="image" src="https://github.com/HuzaibShafi/market_Strategy/assets/17618846/8f5aadce-89db-47ef-848a-f464d00be3eb">
Figure 7: QQ plot

The line in the QQ plot represents the expected quantiles of a normal distribution, and most points align
closely with this line; it indicates that the residuals are approximately normally distributed. However, there
are a few points that deviate noticeably from the line, which indicates the presence of outliers or
observations with unusual characteristics.

We were successful in fostering trust in the dependability and resilience of our model by disclosing the
findings of the following tests and being open about the underlying presumptions and constraints.
