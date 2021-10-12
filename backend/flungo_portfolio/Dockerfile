FROM python:3.10

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /code
ENV PYTHONPATH=${PYTHONPATH}:${PWD}

RUN python -m pip install --upgrade pip

RUN pip install poetry

COPY poetry.lock pyproject.toml /code/

RUN poetry config virtualenvs.create false --local

RUN poetry install --no-dev

COPY . /code/