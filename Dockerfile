FROM pypy:3.6

RUN apt-get update && apt-get -y install libgeos-dev build-essential swig cmake lsb-release pypy-setuptools

# Ortools
RUN wget https://github.com/google/or-tools/archive/v7.1.zip && \
    unzip v7.1.zip

RUN apt-get install -y python3-pip

RUN cd or-tools-7.1 && \
    make -j 4 third_party

RUN cd or-tools-7.1 && \
    make -j 4 python

RUN echo "deb http://ftp.debian.org/debian testing main" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -t testing -y g++

COPY requirements.txt or-tools-7.1/
RUN pypy3 -m pip install -r or-tools-7.1/requirements.txt

RUN apt-get install -y vim

RUN cd or-tools-7.1/ && mkdir /usr/local/site-packages/ortools_space_planner_pypy && \
    find . -name "*.h" -exec cp --parents {} /usr/local/site-packages/ortools_space_planner_pypy \; && \
    find . -name "*.inc" -exec cp --parents {} /usr/local/site-packages/ortools_space_planner_pypy \; && \
    cp -r ./lib /usr/local/site-packages/ortools_space_planner_pypy && \
    cp -r ./dependencies/install/lib/* /usr/local/site-packages/ortools_space_planner_pypy/lib/ && \
    rm -rf /or-tools-7.1

COPY __init__.py /usr/local/site-packages/ortools_space_planner_pypy/

# from ortools_space_planner_pypy import operations_research as ortools
