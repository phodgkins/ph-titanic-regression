FROM python
COPY src ./src/
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
WORKDIR /src/run
CMD ["python3", "titanic-regression.py"]