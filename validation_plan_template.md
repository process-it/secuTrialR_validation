# Validation plan Release XXX

## Introduction

The secuTrialR package is an R package used to read and process clinical trial data from secuTrial. The validation package provides version controlled builds and documentation of the software in order to be used in the GCP regulated environment. Nevertheless the usage of the package in the R installation requires a controlled and validated IT infrastructure managed by the respective organisation.

## Scope

This validation plan applies to the complete validation of the current release of the secuTrialR package and ends with acceptance of the software packack on the CRAN repository.

## System Description

|Name|Value|
|-----|-----|
|System Name|*secuTrialR*|
|Release|*XXX*|
|Planned release date|DD-MMM-YYYY|
|Validation package location|[Link](https://github.com/SwissClinicalTrialOrganisation/secuTrialR_validation/tree/master/release_docs)|
|Code repository|XXX|

## Definitions and Abbreviations



## Validation Strategy

The validation of the software package is executed according to the [R package validation guideline] and follows a risk based approach. The following steps are executed:

|Step|Description|
|-----|-----|
|Planning|The validation plan summarizes the planning of the release|
|Specification|User requirements, functional specifications and a functional risk assessment are written using the GitHub issue tracking functionality. documents are created automatically (see description below)|
|Implementation|The software design specification and software development|
|Verification|The verification of the software consists of the creation of test cases and execution of automated unit tests and build creation (see testing strategy)|
|Reporting|The validation results verify that the steps are executed as planned|

## Testing Strategy

Unit tests were defined in the [specifications](https://github.com/PatrickRWright/R_package_validation/blob/master/README.md#specification) and implemented in R. The technical foundation is based on the standards defined by the [testthat](https://cloud.r-project.org/web/packages/testthat/index.html) framework.

|Test phase|Description|
|-----|-----|
|Functional Test|The testing of the developed software consists of a set of automated unit tests against the functional specification that run during the build creation on the test environment. The build and tests of the software are run for Linux on [Travis CI](https://travis-ci.com/) and for Windows on [AppVeyor](https://ci.appveyor.com/). The log files of the successful builds (indicated by "Build success" or "Your build exited with 0." at the bottom of the log) part of the validation package (test/build reports)|
|Integration/compliance Test|The successful integration of the software in R is achieved by.... Compliance with [CRAN policies](https://cran.r-project.org/web/packages/policies.html) is achieved by package acceptance on the CRAN platform.|

## Acceptance Criteria

The acceptance criteria is met if
1. all automated unit tests are successful and the new build is created automatically
2. the [CRAN policies](https://cran.r-project.org/web/packages/policies.html) 

## Documentation

The following documents will be created during the validation activities and are part of the validation package. The document creation is partially automated (see document type). The documents are created in the secuTrialR_validation project and after successful validation copied to the [secuTrialR/inst project folder](https://github.com/SwissClinicalTrialOrganisation/secuTrialR/tree/master/inst) and approved by a pull request.

|Document|Description|Type|
|-----|-----|-----|
|Validation Plan|Describes the validation approach and steps|manual|
|User Requirement Specification|Describes the software functionality from an end user perspective|automated|
|Functional Specification|Describes the software functionality|automated|
|Design Specification|Describes the detailed technical design of the software|manual|
|Traceability Matrix|Visualizes the traceability from URS to FS to Testcase|automated|
|Test Specification|Describes the test steps that are executed|automated|
|Test/Build Report|Provides the evidence that the tests and build ran without deviation|automated|
|User Manual|Description of the functionality and installation guideline|automated|
|Validation Report|Summarizes the validation activities|manual|

### Automated document creation

The documents are created using the GitHub API the specifications implemented in the GitHub issue tracker were exported (i.e. `parse_issue_json_to_csv()`) to a comma-separated values (`*.csv`) file.

The `*.csv` file is processed with `prepare_validation_documents()`) into four individual markdown (`*.md`) files. There is a file for the user requirements, the functional specifications, the user manual, the test descriptions and finally a file with the traceability matrix showing that every user requirement is convered by at least one functional specification and at least one test.
