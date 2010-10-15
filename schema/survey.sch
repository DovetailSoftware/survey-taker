'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Product        :  Survey Taker Schema Modification File
'
' Name           :  survey.sch
'                                                                           
' Description    :  Contains schema modifications required for the product
'
' Author          : First Choice Software, Inc.
'                   4412 Spicewood Springs Road
'                   Austin, TX  78759
'                   (512) 418-2905
'
' Platforms       : This version supports Clarify 4.5 and later
'
' Updates		  : Added relations to tables interact and commit_log
'
' Copyright (C) 1999, 2000 First Choice Software, Inc.
' All Rights Reserved
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This file describes the changes to be made to your Clarify schema. Each of the 
sections describe what you have to do, and include the sample code that must be 
placed in your schema file.

All fields and relations MUST be placed at the end of their respective sections for
their data objects.

Any relation that is declared as USER_DEFINED must be located after any other 
relations that are defined by Clarify. Both the relation and the inverse relation
must have the USER_DEFINED notation, or an error will be reported during the update.


Perform the following modifications:


1) Add this relation to END of the site object:

,
    site2surv_ans OTM surv_ans USER_DEFINED
     INV_REL=surv_ans2site     COMMENT="Survey questions answered for this site"

2) Add this relation to the END of the contact object:

,
    contact2surv_ans OTM surv_ans USER_DEFINED
     INV_REL=surv_ans2contact     COMMENT="Survey questions answered for this contact"

3) Add this relation to the END of the bus_org object:

,
    bus_org2surv_ans OTM surv_ans USER_DEFINED
     INV_REL=surv_ans2bus_org     COMMENT="Survey questions answered for this business organization"

4) Add this relation to the END of the case object:

,
    case2surv_ans OTM surv_ans USER_DEFINED
     INV_REL=surv_ans2case     COMMENT="Survey questions answered for this case"

5) Add this relation to the END of the interact object:

,
    interact2surv_ans OTM surv_ans USER_DEFINED
     INV_REL=surv_ans2interact     COMMENT="Survey questions answered for this interaction"     
     
6) Add this relation to the END of the commit_log object:

,
    commit_log2surv_ans OTM surv_ans USER_DEFINED
     INV_REL=surv_ans2commit_log     COMMENT="Survey questions answered for this commitment"

7) Add these objects to the end of the file:

OBJECT surv_quest 3520
 SUBJECT="First Choice"
 COMMENT="Survey question to be asked."
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    question  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Survey question"
,
    question_set  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Question set"
,
    answer_type  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=1
     OPTIONAL USER_DEFINED
     COMMENT="Type of answer: 0 = text, 1 = Y/N, 2 = T/F, 3 = multiple choice."
,
    default_ans CMN_DATA_TYPE="long integer" DB_DATA_TYPE=1
     OPTIONAL USER_DEFINED
     COMMENT="Answer that is the default (not defined for text answers)"
,
    num_answers  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=1
     OPTIONAL USER_DEFINED
     COMMENT="How many multiple choices to present."
,
    ans1  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Answer 1"
,
    ans2  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Answer 2"
,
    ans3  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Answer 3"
,
    ans4  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Answer 4"
,
    ans5  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Answer 5"
,
    start_time  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="The start date and time for the question"
,
    end_time  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="The end date and time for the question"
,
    active  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=1
     OPTIONAL USER_DEFINED
     COMMENT="Is the question active? 0=inactive, 1=active"
,
    ask_once  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=1
     OPTIONAL USER_DEFINED
     COMMENT="Should we always ask this question, or only once? 0=always, 1=once"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    surv_quest2surv_ans OTM surv_ans USER_DEFINED
     INV_REL=surv_ans2surv_quest     COMMENT="Answers for this question"
  RELATIONS_END
 OBJECT_END;

OBJECT surv_ans 3521
 SUBJECT="First Choice"
 COMMENT="Answer to survey question."
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    question  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Survey question"
,
    answer CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Survey answer"
,
    date_answered  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="When was the question answered"
,
    surv_taker CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=30
     COMMENT="Login name of user who took the survey"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    surv_ans2surv_quest MTO surv_quest USER_DEFINED
     INV_REL=surv_quest2surv_ans     COMMENT="Question answered"
,
    surv_ans2contact MTO contact USER_DEFINED
     INV_REL=contact2surv_ans     COMMENT="Related contact"
,
    surv_ans2bus_org MTO bus_org USER_DEFINED
     INV_REL=bus_org2surv_ans     COMMENT="Related business organization"
,
    surv_ans2site MTO site USER_DEFINED
     INV_REL=site2surv_ans     COMMENT="Related site"
,
    surv_ans2case MTO case USER_DEFINED
     INV_REL=case2surv_ans     COMMENT="Related case"

,
    surv_ans2interact MTO interact USER_DEFINED
     INV_REL=interact2surv_ans     COMMENT="Related interaction"

,
    surv_ans2commit_log MTO commit_log USER_DEFINED
     INV_REL=commit_log2surv_ans     COMMENT="Related commitment"


  RELATIONS_END
 OBJECT_END;

