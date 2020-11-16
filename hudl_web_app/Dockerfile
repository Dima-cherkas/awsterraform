FROM python:alpine3.7 
COPY . /hudl_project
WORKDIR /hudl_project
RUN pip3 install -r requirements.txt 
EXPOSE 5000 
ENTRYPOINT [ "python" ] 
CMD [ "web.py" ]