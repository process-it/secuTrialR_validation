# R package validation guideline - custom built software

## Specification

Every functionality needs:
 - to be defined as a very briefly written high level **user requirement**
 - to be defined as a more technically written **functional specification**
 - to be technically tested and the **tests** need to be described

We define this per R function in the R package to be validated. Thus, every R function fulfills one **user requirement**,
has one **functional specification** and may have several **tests** (at least one) depending on the [risk](https://github.com/PatrickRWright/R_package_validation/blob/master/README.md#risk-assessment) category assigned
to the **functional specification**.

This can be achieved by starting a new GitHub Issue and then selecting one of the templates from **User requirement**, **Functional specification** or **Test specification**.

The links between a related **user requirement**, **functional specification** and **tests** need to be specifically stated. This can be performed by using the hashtag symbol (#) in combination with the id of the Issue.

## Test framework `testthat`
Tests can be implemented by employing the [`testthat`](https://cloud.r-project.org/web/packages/testthat/index.html) 
framework and be independently verified using [Travis CI](https://travis-ci.com/) for Linux builds and
[AppVeyor](https://ci.appveyor.com/) for Windows builds. The log files of the successful external builds should be downloaded
and added to the the validation release [versioning](https://github.com/PatrickRWright/R_package_validation#versioning) 
files. "Build success" and "Your build exited with 0." at the very bottom of the logs indicate successful builds passing all
tests.

## Versioning

All **user requirements**, **functional specifications** and **tests** need to be compiled into individual version controlled
documents (one per class) and released together with every official release of the software.

This information can be retrieved automatically from the GitHub API by using the `parse_issue_json_to_csv()`
in R as shown in the below example. The source code can be found in the [src](src) directory of this repository.

```r
# will write the file github_issues.csv in your current working directory
parse_issue_json_to_csv(repos_owner = "PatrickRWright", repos_name = "R_package_validation")
```

The information returned to the `*.csv` file from the above call can then be compiled into three individual `*.md` files.
One for each of **user requirements**, **functional specifications** and **tests**. The source code can be found in the
[src](src) directory of this repository.


```r
# writes into your current working directory
prepare_validation_documents("github_issues.csv")
```

## Traceability Matrix

A matrix representation of which user requirements are covered by which functional specifications and which tests. The matrix is also built as an `*.md` file by `prepare_validation_documents()`.

## Risk assessment

Risk is assessed for every functional specification individually based on the following method.

Classify: (:red_circle: High = 3, :large_blue_circle: Medium = 2 , :white_circle: Low = 1)  
**Severity** - How detrimental is a failure of the assessed functionality?  
**Probability** - How likely is a failure of the assessed functionality?  
**Detectability** - How quickly will a failure of the assessed functionality be detected? 

The selection of high, medium or low should be briefly explained in the **functional specification**.

---

Assess the **Risk class** based on **probability** and **severity** in the below matrix.

**Risk class matrix**

|Probability (x) / Severity (y) | High | Medium | Low |
|-------------------------------|------|--------|-----|
| **High**                      |   3 :red_circle:  |   3 :red_circle:   |  2 :large_blue_circle: |
| **Medium**                    |   3 :red_circle: |   2 :large_blue_circle:   |  1 :white_circle: |
| **Low**                       |   2 :large_blue_circle: |   1 :white_circle:   |  1 :white_circle: |

---

Assess the **Final risk** based on the **Risk class** and the **detectability**.

**Final risk matrix**

|Risk class (x) / Detectability (y) | High | Medium | Low |
|-----------------------------------|------|--------|-----|
| **High**                          |   3 :red_circle: |   3 :red_circle:   |  2 :large_blue_circle: |
| **Medium**                        |   3 :red_circle: |   2 :large_blue_circle:   |  1 :white_circle: |
| **Low**                           |   2 :large_blue_circle: |   1 :white_circle:   |  1 :white_circle: |

This can be performed by using the `risk_calculator()` function in R as shown in the below example.
The source code can be found in the [src](src) directory of this repository.

```r
# returns 3
risk_calculator(severity = 3, probability = 1, detectability = 3)
```




