FROM rocker/r-base:4.5.1
COPY src ./src/

WORKDIR /src/run_r
# copy files from current 
COPY . .

#Install packages
RUN Rscript install_packages.R

CMD ["Rscript", "titanic_regression.R"]