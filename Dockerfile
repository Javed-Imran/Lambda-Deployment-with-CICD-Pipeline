From python:3.9.18-slim

WORKDIR /my_app

COPY . /my_app

CMD ["python", "lambda.py"]