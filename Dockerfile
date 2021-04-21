FROM python:3.9.4-buster
RUN apt-get update
RUN apt-get --yes install gcc g++ gfortran make libblas-dev liblapack-dev libpcre3-dev libarpack2-dev libcurl4-gnutls-dev epstool libfftw3-dev transfig libfltk1.3-dev libfontconfig1-dev libfreetype6-dev libgl2ps-dev libglpk-dev libreadline-dev gnuplot-x11 libgraphicsmagick++1-dev libhdf5-serial-dev libsndfile1-dev llvm-dev lpr texinfo libgl1-mesa-dev libosmesa6-dev pstoedit portaudio19-dev libqhull-dev libqrupdate-dev libsuitesparse-dev texlive libxft-dev zlib1g-dev autoconf automake bison flex gperf gzip icoutils librsvg2-bin libtool perl rsync tar qtbase5-dev qttools5-dev qttools5-dev-tools libqscintilla2-qt5-dev wget git libsundials-dev gnuplot x11-apps

RUN pip3 install oct2py

RUN apt-get install curl
RUN LOCATION=$(curl -s https://api.github.com/repos/cerr/octave-colab/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/cerr/octave-colab/archive/" substr($2, 2, length($2)-3) ".zip"}') \
; curl -L -o octavecolab.zip $LOCATION
 
RUN apt-get --yes install zip
RUN unzip octavecolab.zip -d octavecolab
RUN tar xzvf "octavecolab/octave-colab-6.2/octavecolab.tar.gz"

RUN export OCTAVE_EXECUTABLE=./octavecolab/bin/octave-cli && export PATH=./octavecolab/bin/:$PATH

RUN apt-get --yes install octave liboctave-dev

RUN wget https://nchc.dl.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/image-2.12.0.tar.gz && \
    wget https://nchc.dl.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/io-2.6.1.tar.gz  && \
    wget https://nchc.dl.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/statistics-1.4.2.tar.gz 

RUN octave --eval "pkg install io-2.6.1.tar.gz" && \
    octave --eval "pkg install image-2.12.0.tar.gz" && \
    octave --eval "pkg install statistics-1.4.2.tar.gz"


RUN mkdir /content && cd /content && git clone https://github.com/cerr/CERR.git && cd ./CERR && git checkout octave_dev && cd /

RUN mkdir /ana
COPY radiomic_and_dosimetric_feature_extraction.m /ana/radiomic_and_dosimetric_feature_extraction.m
COPY run_cerr.py /ana/run_cerr.py

ENTRYPOINT [ "python3", "/ana/run_cerr.py" ]