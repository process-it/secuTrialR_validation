**Functional specification, Medium risk**  
ID: #16  
Wrap reading, labeling, factorizing and date(time) conversion  
Change date: 2020-04-24T14:11:10Z  
Creation date: 2020-04-24T14:11:10Z  
Weblink: https://github.com/SwissClinicalTrialOrganisation/secuTrialR_validation/issues/16  
**Description:**  
Since it is advised to read a secuTrial data export and always perform a factorization, date(time) conversion and labeling it is most user friendly to wrap all of these processes into in a single function. [read_secuTrial()](https://github.com/SwissClinicalTrialOrganisation/secuTrialR/blob/master/R/read_secuTrial.R) performs this task and returns a `secuTrialdata` object which is factorized, labeled and has converted date(time)s.

**Risk assessment: 2**
For each select one of: 1 = low, 2 = medium, 3 = high
Explain each selection briefly.
**Severity**: 3; If there is an error during data reading, all downstream processes are compromised. Most risks are, however, inherited from the wrapped functions.
**Probability**: 1; Wrapping functions in not inherently complex. Thus the likelihood of errors caused purely by the wrapper is small.
**Detectability**: 2; Severe issues are likely to be detected reasonably swiftly during interaction with the data.

**Linkage to related documents:**  
User requirement: #5
Test: #7 #8 #9 #11 #13 #15 



---
**Functional specification, Low risk**  
ID: #14  
Label variables in a secuTrial data export  
Change date: 2020-04-24T13:43:43Z  
Creation date: 2020-04-24T13:43:43Z  
Weblink: https://github.com/SwissClinicalTrialOrganisation/secuTrialR_validation/issues/14  
**Description:**  
During database setup in secuTrial it is possible to add units and labels to variables to increase tangibility during data entry. This information is also potentially useful during analysis in R and can be added to the variables in R with the [label_secuTrial()](https://github.com/SwissClinicalTrialOrganisation/secuTrialR/blob/master/R/labels_secuTrial.R) function.

**Risk assessment: 1**
For each select one of: 1 = low, 2 = medium, 3 = high
Explain each selection briefly.
**Severity**: 1; The raw data is not touched and wrong labels are unlikely to cause major problems.
**Probability**: 1; Labeling is not an inherently complex process and thus failures are unlikely.
**Detectability**: 1; If the labels are used during analysis it is highly likely that wrong labels are easily detected.

**Linkage to related documents:**  
User requirement: #4 #5
Test: 



---
**Functional specification, Low risk**  
ID: #12  
Factorize categorical variables from a secuTrial data export  
Change date: 2020-04-24T13:18:08Z  
Creation date: 2020-04-24T13:14:36Z  
Weblink: https://github.com/SwissClinicalTrialOrganisation/secuTrialR_validation/issues/12  
**Description:**  
In order to perform a correct analysis of the data in categorical variables it is necessary to be aware of all feasible categories. It is, however, easily possible to overlook categories which were not chosen during data entry. To remedy this situation, secuTrial allows to export reference values separately. If this is done, the `cl` table in the secuTrial data export contains all necessary information to transform the data to a factorized form within R statistics which also contains factor levels which were not selected during data entry. In `secuTrialR` this task is performed by the [factorize_secuTrial()](https://github.com/SwissClinicalTrialOrganisation/secuTrialR/blob/master/R/factorize.R) function. It adds a new column to the data named `original_variable_name.factor` in which the factorized version of the raw data is saved.

**Risk assessment: 1**
For each select one of: 1 = low, 2 = medium, 3 = high
Explain each selection briefly.
**Severity**: 3; Wrong transformation of data corrupts the data and would have severe influence.
**Probability**: 1; The transformation is not an inherently complex process and thus failures are unlikely.
**Detectability**: 1; Failure during conversion likely cause the R code to fail and will likely be swiftly detected.

**Linkage to related documents:**  
User requirement: #3 #5 
Test: 



---
**Functional specification, Low risk**  
ID: #10  
Convert date and datetime variables from a secuTrial data export  
Change date: 2020-04-24T13:17:52Z  
Creation date: 2020-04-24T12:14:21Z  
Weblink: https://github.com/SwissClinicalTrialOrganisation/secuTrialR_validation/issues/10  
**Description:**  
The date format returned by secuTrial is not automatically intuitive both for users and for digital systems. Thus `secuTrialR` incorporates the functionality `dates_secuTrial()` to add additional columns to the datasets within a `secuTrialdata` object. The additional columns contain the translations of the date(time) format within secuTrial to a date(time) format more easily usable in R (i.e. class `Date`, `POSIXct`, `POSIXt`) and are called e.g. `original_variable_name.date` or `original_variable_name.datetime`.

**Risk assessment: 1**
For each select one of: 1 = low, 2 = medium, 3 = high
Explain each selection briefly.
**Severity**: 3; Wrong transformation of dates corrupts the data and would have severe influence.
**Probability**: 1; The transformation is not an inherently complex process and thus failures are unlikely. 
**Detectability**: 1; Failures during conversion likely return `NA` values. Internal checks are implemented to check if not all data was converted and users are informed in the case of failures.

**Linkage to related documents:**  
User requirement: #2 #5 
Test: #11 



---
**Functional specification, High risk**  
ID: #6  
Read non-rectangular secuTrial export data into R  
Change date: 2020-04-24T12:34:03Z  
Creation date: 2020-04-24T10:14:51Z  
Weblink: https://github.com/SwissClinicalTrialOrganisation/secuTrialR_validation/issues/6  
**Description:**  
A secuTrial data export contains the study data, data structure, and information on the export options. All three aspects need to be taken into consideration during the process of reading data into R statistics. 

Export options are extracted from an HTML file with the text parsing function [read_export_options()](https://github.com/SwissClinicalTrialOrganisation/secuTrialR/blob/master/R/read_export_options.R).

Study data and data structure information is available from CSV files within the secuTrial data export and is read with the [read_export_table()](https://github.com/SwissClinicalTrialOrganisation/secuTrialR/blob/master/R/read_export_table.R) function.

Both, reading of export options and reading of export data are combined by the function [read_secuTrial_raw()](https://github.com/SwissClinicalTrialOrganisation/secuTrialR/blob/master/R/read_secuTrial_raw.R) which produces an S3 object of class `secuTrialdata`. This object is the central input for all downstream functionalities in `secuTrialR`.

**Risk assessment: 3**
For each select one of: 1 = low, 2 = medium, 3 = high
Explain each selection briefly.
**Severity**: 3; If there is an error during data reading, all downstream processes are compromised.
**Probability**: 2; secuTrial exports can be heterogeneous. Thus it is possible for deviations to occur especially if the export does not adhere to the [suggested export options](https://github.com/SwissClinicalTrialOrganisation/secuTrialR#recommended-export-options).
**Detectability**: 2; Severe issues are likely to be detected reasonably swiftly during interaction with the data.

**Linkage to related documents:**  
User requirement: #1 #5
Test: #7 #8 #9 



---
