#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_NAME = breast-cancer-prediction
PYTHON_VERSION = 3.10
PYTHON_INTERPRETER = python
PYTHONIOENCODING = utf-8
export PYTHONIOENCODING

#################################################################################
# COMMANDS                                                                      #
#################################################################################


## Install Python Dependencies
.PHONY: requirements
requirements:
	$(PYTHON_INTERPRETER) -m pip install -U pip
	$(PYTHON_INTERPRETER) -m pip install -r requirements.txt
	


## Delete all compiled Python files
.PHONY: clean
clean:
	del /q /s *.pyc *.pyo __pycache__
	del /s /q models\*.pkl
	del /s /q data\*.pkl
	del /s /q data\result\*.csv




## Run the python files and create predictions
.PHONY: breast_cancer_prediction
breast_cancer_prediction: 
	$(PYTHON_INTERPRETER) -m breast_cancer_prediction.config
	$(PYTHON_INTERPRETER) -m breast_cancer_prediction.dataset
	$(PYTHON_INTERPRETER) -m breast_cancer_prediction.features
	$(PYTHON_INTERPRETER) -m breast_cancer_prediction.modeling.train
	$(PYTHON_INTERPRETER) -m breast_cancer_prediction.modeling.predict



## Lint using flake8 and black (use `make format` to do formatting)
.PHONY: lint
lint:
	flake8 breast_cancer_prediction
	isort --check --diff --profile black breast_cancer_prediction
	black --check --config pyproject.toml breast_cancer_prediction



## Format source code with black
.PHONY: format
format:
	black --config pyproject.toml breast_cancer_prediction




## Set up python interpreter environment
.PHONY: create_environment
create_environment:
	@bash -c "if [ ! -z `which virtualenvwrapper.sh` ]; then source `which virtualenvwrapper.sh`; mkvirtualenv $(PROJECT_NAME) --python=$(PYTHON_INTERPRETER); else mkvirtualenv.bat $(PROJECT_NAME) --python=$(PYTHON_INTERPRETER); fi"
	@echo ">>> New virtualenv created. Activate with:\nworkon $(PROJECT_NAME)"
	


#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys; \
lines = '\n'.join([line for line in sys.stdin]); \
matches = re.findall(r'\n## (.*)\n[\s\S]+?\n([a-zA-Z_-]+):', lines); \
print('Available rules:\n'); \
print('\n'.join(['{:25}{}'.format(*reversed(match)) for match in matches]))
endef
export PRINT_HELP_PYSCRIPT

help:
	@$(PYTHON_INTERPRETER) -c "${PRINT_HELP_PYSCRIPT}" < $(MAKEFILE_LIST)
