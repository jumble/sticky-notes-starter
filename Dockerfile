FROM ubuntu:20.04

# create user
ARG USERNAME=jumble
RUN groupadd -g 1000 ${USERNAME}
RUN useradd -d /home/${USERNAME} -s /bin/bash -m ${USERNAME} -u 1000 -g 1000

# create workdir
ARG WORKDIR=/home/${USERNAME}/notes/
RUN mkdir ${WORKDIR}
WORKDIR ${WORKDIR}

# install system requirements
ARG SYSTEM_REQUIREMENTS_FILE=requirements.sys.txt
COPY ${SYSTEM_REQUIREMENTS_FILE} ${WORKDIR}
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y $(grep -vE "^\s*#" ${SYSTEM_REQUIREMENTS_FILE}  | tr "\n" " ") \
    && rm -rf /var/lib/apt/lists/*

# install language requirements
ARG PYTHON_REQUIREMENTS_FILE=requirements.py.txt
COPY ${PYTHON_REQUIREMENTS_FILE} $WORKDIR
RUN python3.9 -m pip install -r ${PYTHON_REQUIREMENTS_FILE}

# copy in code
COPY ./ ${WORKDIR}

# change db owner
RUN chown ${USERNAME} ${WORKDIR}
RUN chmod +rw ${WORKDIR}
RUN chown ${USERNAME} notes.db
RUN chmod +rw notes.db

# become user
USER ${USERNAME}
ENV HOME /home/${USERNAME}

CMD python3.9 notes.py