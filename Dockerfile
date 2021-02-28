FROM python:latest
ADD PythonProgram.py /
RUN pip install flask
RUN pip install flask_restful
EXPOSE 3333
CMD [ "python","./PythonProgram.py"]
