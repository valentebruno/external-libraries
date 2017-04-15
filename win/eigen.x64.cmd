:: Eigen
:: ====

@call %VSSETUP_COMMAND%
@cd src\%1\

xcopy /e Eigen %2\Eigen\
xcopy /e unsupported\Eigen %2\unsupported\
