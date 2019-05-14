#!/usr/bin/env bash

EXIT_CODE=0

pylint src/fixed_linter_errors || EXIT_CODE=1

mypy src/fixed_linter_errors || EXIT_CODE=1

pycodestyle src/fixed_linter_errors || EXIT_CODE=1

python -m flake8 src/fixed_linter_errors || EXIT_CODE=1

exit ${EXIT_CODE}
