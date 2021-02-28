FROM python:latest
ADD main.py /
RUN pip install Flask
RUN pip install flask_restful
RUN python3 -m venv venv
RUN  export FLASK_APP=main.py
EXPOSE 5001
ENTRYPOINT [ "python" ] 
CMD [ "main.py" ]
