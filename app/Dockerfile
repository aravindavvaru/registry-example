FROM python:3.9.2
WORKDIR app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY . .
EXPOSE 8000
ARG environment=""
ENTRYPOINT [ "python3","app.py","-e","${environment}"]