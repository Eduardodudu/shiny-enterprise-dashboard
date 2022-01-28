FROM rocker/r-ver:4.1.2
RUN apt-get update && apt-get install -y  git-core imagemagick libcurl4-openssl-dev libgit2-dev libglpk-dev libgmp-dev libicu-dev libmagic-dev libmagick++-dev libsodium-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
ENV RENV_VERSION 0.15.2
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
WORKDIR /project
COPY renv.lock renv.lock
RUN R --vanilla -s -e 'renv::restore(); shiny::runApp(host = "0.0.0.0", port = 14618)'
