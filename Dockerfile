FROM python:3.9.0

# install system requirements
ARG SYSTEM_REQUIREMENTS_FILE=requirements.sys.txt
COPY $SYSTEM_REQUIREMENTS_FILE .
RUN apt-get update \
    && apt-get install -y $(grep -vE "^\s*#" $SYSTEM_REQUIREMENTS_FILE | tr "\n" " ") \
    && rm -rf /var/lib/apt/lists/*

# install language requirements
ARG PYTHON_REQUIREMENTS_FILE=requirements.py.txt
RUN pip install -r $PYTHON_REQUIREMENTS_FILE

RUN adduser --quiet --disabled-password qtuser

CMD python notes.py