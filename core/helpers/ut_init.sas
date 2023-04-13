%macro ut_init(type=, description=, expected_result=);
/*
    Macro to create and initialize a test "container".
    This "container" is inserted once the test is complete into the result dataset
    This function is used by assert functions and shoudn't be used out of this scope
    type:               type of test
    description:        description of the test
    expected_result:    expected result of the test (either PASS or FAIL)
*/
    *-- Increment test sequence by 1 --*;
    %let ut_seq = %eval(&ut_seq. + 1);

    *-- Derive test id --*;
    %let ut_id = %cmpres(&ut_grp_id..&ut_seq.);

    *-- Set test type --*;
    %if %sysevalf(%superq(type) ne, boolean) %then              %let ut_type = %nrbquote(&type.);
    %else                                                       %let ut_type = %lowcase(%sysmexecname(%sysmexecdepth - 2));

    *-- Set test description --*;
    %if %sysevalf(%superq(description) ne, boolean) %then       %let ut_desc = %nrbquote(&description.);
    %else                                                       %let ut_desc = Test #&ut_id.;

    *-- Set expected test result (PASS by default) --*;
    %if %sysevalf(%superq(expected_result) =, boolean) %then    %let expected_result = PASS;
    %let ut_exp_res = &expected_result.;

    *-- Set test result to FAIL by default --*;
    %let ut_res = FAIL;

    *-- Reset test details --*;
    %let ut_det = ;
%mend ut_init;