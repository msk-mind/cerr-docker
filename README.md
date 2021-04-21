### Run the CERR implimentation bridged via oct2py in a docker container

Idea: A few lines of python code invoke a matlab function (`radiomic_and_dosimetric_feature_extraction`), where the sampleData is pushed
into the octave instance prior to running, and the dose information is pulled
out once the function completes.

There's an encompassing function/script called  in /ana/

To build: `docker build . --tag msk-mind-cerr:latest`

To run: `docker run -it msk-mind-cerr:latest`
