FROM jupyter/datascience-notebook:latest

RUN pip install jupyter_contrib_nbextensions \
                jupyter_nbextensions_configurator statsmodels graphviz \
                python-igraph tqdm pymc3 gensim implicit annoy keras

RUN jupyter nbextensions_configurator enable
RUN jupyter contrib nbextension install --user
RUN jupyter-nbextension enable nbextensions_configurator/config_menu/main
RUN jupyter-nbextension enable contrib_nbextensions_help_item/main
RUN jupyter-nbextension enable autosavetime/main
RUN jupyter-nbextension enable code_prettify/code_prettify
RUN jupyter-nbextension enable table_beautifier/main
RUN jupyter-nbextension enable toc2/main
RUN jupyter-nbextension enable spellchecker/main
RUN jupyter-nbextension enable toggle_all_line_numbers/main
RUN jupyter-nbextension enable execute_time/ExecuteTime
RUN jupyter-nbextension enable notify/notify
RUN jupyter-nbextension enable codefolding/main
RUN jupyter-nbextension enable varInspector/main
RUN jupyter-nbextension enable nbextensions_configurator/tree_tab/main
RUN jupyter-nbextension enable tree-filter/index
RUN jupyter-nbextension enable codefolding/edit
RUN jupyter-nbextension enable jupyter-js-widgets/extension

USER root

RUN apt-get update && apt-get install -y git graphviz

USER $NB_USER

# XGBoost
RUN cd /home/$NB_USER && \
  git clone --recursive https://github.com/dmlc/xgboost && \
  cd xgboost && \
  make -j4

ENV PYTHONPATH /home/$NB_USER/xgboost/python-package
