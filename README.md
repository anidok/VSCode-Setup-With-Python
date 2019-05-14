# VSCode-Setup-With-Python
This project contains instructions to setup Visual Studio Code and linters for Python along with sample code base.

## Python linting tools
It's good to get a bit familiar with python style guides (pep8 naming) and other linting concepts.
https://www.python.org/dev/peps/pep-0008/
https://pylint.readthedocs.io/en/latest/
http://flake8.pycqa.org/en/latest/
https://mypy.readthedocs.io/en/stable/

Feel free to explore the below link if you want to deep dive into using linters along with Visual Studio Code.
https://code.visualstudio.com/docs/python/linting

**Note: Though this project illustrates a portion of what have been explained there in the link, the emphasis is more on how to use linters in general and not specifically with Visual Studio Code.** 

Make sure python (preferred python3.7) is added to path.

	python --version
	or		
	python3.7 --version

Install virtualenv using pip.

	pip install virtualenv

First create a virtual environment for the project. 

	virtualenv -p python3.7 venv or virtualenv venv
	. venv/bin/activate (Linux)
	. venv/Scripts/activate (Windows - Preferred from CLI like git bash)

### Install dependencies

	pip install -r requirements.txt

This will install all the dependencies (pylint, flake8, etc) mentioned in the requirements file.

### Overview

The project contains two copies of the same code, one having linter errors and the other one having green signal from linters (i.e, no errors). The functionalities of different linters have been explained in the links provided above. 

Pylint in general uses a configuration file. You can create a default configuration file using Pylint (as also mentioned in the [link](https://code.visualstudio.com/docs/python/linting) above:

	pylint --generate-rcfile > .pylintrc
or you can use the existing .pylintrc file which is already a part of the project. Make sure to keep this file in the root directory of the project. You can edit this file to make configuration changes as per your need, if actually needed. We can also define some options for the other linters using [setup.cfg](https://github.com/anidok/VSCode-Setup-With-Python/blob/master/setup.cfg) file. We just need to define different sections along with the options for different linters. Find more about it [here](https://code.visualstudio.com/docs/python/linting#_pep8-pycodestyle).

### Let's play with linting
Now, we will look at some of the linting errors and try to fix them. As mentioned, this project contains a sample python program inside a package with name "with-linter-errors" and the other clean python program inside another package "fixed_linter_errors". We can run all the linters one by one on each of the packages and that will basically scan all the code residing within that package and generate the report along with suggestions. For ease, we have put all the linting commands inside a single script. If we run a particular linting command against a python code module or a package, it scans the code and highlights errors, if any and also it returns with a status code zero on success, non negative status code otherwise. Getting a zero return code from linters is the green signal we are targeting for. We can check this using the command to check status code of last command:

	echo $?

Let's execute the first script and see the outputs:

	sh scripts/with-linter-errors/lint.sh

This script will run all the linters mentioned in the script against the package "with-linter-errors". Note that the use of variable EXIT_CODE in the script is to store any non-negative status code, as it might come from any of the linters and we want to delegate it to the end.

![alt text](https://github.com/anidok/VSCode-Setup-With-Python/blob/master/images/lint-error1.JPG)

![alt text](https://github.com/anidok/VSCode-Setup-With-Python/blob/master/images/lint-error2.JPG)

Looking at the above outputs, it seems like a pretty big list for a single python file. All the errors look quite explanatory. We'll need to go through each of the errors and try to fix them as per the explanations. The easy ones like indentation issues, white spacing, blank lines, etc can be handled without much pain. It's not necessary to fix each of the warnings. There might be cases where we need something but linter doesn't allow it normally. For example,

	src\with-linter-errors\class_movies.py:2:1: R0913: Too many arguments (6/5) (too-many-arguments)

This particular warning tells that we have defined 6 arguments for Movie class but only 5 are allowed. We can either increase this limit by modifying .pylintrc file or we can simply ignore this warning by adding some extra comment (mentioned below) in the python code just above the class definition which is the source of the error:

	# pylint: disable=too-many-arguments

Now if we look at the above error, it said "too-many-arguments" which is basically a flag for pylint. We are just disabling this flag for our Movie class so that Pylint simply ignores this error for this class. We can disable any other flags if Pylint makes extra noises but make sure to disable the flag only when you don't have a choice.

Let's check the return code.
![alt text](https://github.com/anidok/VSCode-Setup-With-Python/blob/master/images/exit-code.JPG)

The return code is 1 (non-zero) and that'd mean our code has not passed the lint test.

Let's run the lint test on the cleaned version of same code and see the outputs.

	sh scripts/fixed_linter_errors/lint.sh

![alt text](https://github.com/anidok/VSCode-Setup-With-Python/blob/master/images/lint-green.JPG)

Looks like linter has approved this version of the code as we didn't receive any warnings and return code from lint script is also 0. Hence, this version has passed the lint test.

As it's quite clear that we mostly used CLI to run linting and using Visual Studio Code just to make code changes. However, we can also setup linters for the IDE that might help pointing out some of the obvious errors (blank lines, white spaces, etc). It is suggested to look into the provided [link](https://code.visualstudio.com/docs/python/linting#_enable-linters) to use these features for your project.



