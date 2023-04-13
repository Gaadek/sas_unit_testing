%macro ut_assert_macro(description=, stmt=, expected_result=PASS);
/*
    To be used to assert some macro code is valid
    description:        description to explain why a macro statement should be valid (or not)
    stmt:               macro statement to evaluate
    expected_result:    either PASS or FAIL
*/
    %ut_init(type=ut_assert_macro, description=&description., expected_result=&expected_result.);

    *-- Statement provided to check macro varialbe value, so continue testing --*;
    %if %unquote(&stmt.) %then %do;
        %let ut_res = PASS;
        %let ut_det = Test %superq(stmt) (evaluated as %unquote(&stmt.)) is valid;
    %end;
    %else %do;
        %let ut_res = FAIL;
        %let ut_det = Test %superq(stmt) (evaluated as %nrbquote(&stmt.)) is not successful;
    %end;

    %ut_log_result;
%mend ut_assert_macro;