### Run the CERR implimentation bridged via oct2py in a docker container

Idea: A few lines of python code invoke a matlab function, the sampleData is pushed
into the octave instance prior to running, and the dose information is pulled
out later.

To build: `docker build . --tag aauker/msk-mind-cerr:latest`
To run: `docker run -it aauker/msk-mind-cerr:latest`
