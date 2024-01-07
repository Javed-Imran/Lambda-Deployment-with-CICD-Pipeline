FROM python:3.9.18-slim

WORKDIR /my_app

COPY lambda.py /my_app/

CMD ["python", "lambda.py"]
