FROM python:3.13.7-slim
LABEL authors="Len Washington III"

RUN pip install --root-user-action ignore  \
    requests==2.32.5 \
    playwright==1.55.0 \
    beautifulsoup4==4.13.5 && \
    playwright install --with-deps firefox

ENTRYPOINT ["top", "-b"]