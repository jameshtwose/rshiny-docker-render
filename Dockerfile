FROM rocker/shiny:4
# install R packages required 
# Change the packages list to suit your needs
RUN R -e 'install.packages(c(\
              "shiny", \
              "shinythemes", \
              "plotly"), \
            repos="https://packagemanager.rstudio.com/cran/__linux__/focal/2023-07-31"\
          )'
WORKDIR /home/shinyusr
COPY app.R app.R 
COPY www www
CMD Rscript app.R