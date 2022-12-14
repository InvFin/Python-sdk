.PHONY: clean clean-build clean-pyc clean-test coverage dist docs help install lint check test

.DEFAULT_GOAL := help

APPS_FOLDERS=invfinsdk tests

define BROWSER_PYSCRIPT
import os, webbrowser, sys

from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

test: ## run tests quickly with the default Python
	pytest tests -vv 

test-all: ## run tests on every Python version with tox
	tox

coverage: ## check code coverage quickly with the default Python
	coverage run --source invfinsdk -m pytest
	coverage report -m
	coverage html
	$(BROWSER) htmlcov/index.html

docs: ## generate Sphinx HTML documentation, including API docs
	rm -f docs/invfinsdk.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ invfinsdk
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	$(BROWSER) docs/_build/html/index.html

servedocs: docs ## compile the docs watching for changes
	watchmedo shell-command -p '*.rst' -c '$(MAKE) -C docs html' -R -D .

release:
	make check-all
	twine upload dist/* --verbose

test-release: dist ## package and upload a release
	twine upload -r testpypi dist/* --verbose

dist: clean ## builds source and wheel package
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist

install: clean ## install the package to the active Python's site-packages
	python setup.py install

isort:
	isort ${APPS_FOLDERS}

check-isort:
	isort --df -c ${APPS_FOLDERS}

mypy: ## check types with mypy
	mypy ${APPS_FOLDERS}

flake8: ## check style with flake8
	flake8 ${APPS_FOLDERS}

black: ## run style fixing with black
	black ${APPS_FOLDERS}

check-black: ## check style with black
	black --check ${APPS_FOLDERS}

lint: ## fix style
	isort ${APPS_FOLDERS}
	black ${APPS_FOLDERS}

check: ## check style
	flake8 ${APPS_FOLDERS}
	isort --df -c ${APPS_FOLDERS}
	black --check ${APPS_FOLDERS} 
	mypy ${APPS_FOLDERS}

check-all: ## check style
	make test-release
	twine check dist/*
	flake8 ${APPS_FOLDERS}
	isort --df -c ${APPS_FOLDERS}
	black --check ${APPS_FOLDERS} 
	mypy ${APPS_FOLDERS}

# v0.1.0 -> v0.2.0
bump-minor:
	bump2version minor

# v0.1.0 -> v0.1.1
bump-patch:
	bump2version patch