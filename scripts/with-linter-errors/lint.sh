#!/usr/bin/env bash

EXIT_CODE=0

pylint src/with-linter-errors || EXIT_CODE=1

mypy src/with-linter-errors || EXIT_CODE=1

pycodestyle . || EXIT_CODE=1

python -m flake8 src/with-linter-errors || EXIT_CODE=1

exit ${EXIT_CODE}
