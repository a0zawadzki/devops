from fastapi import FastAPI

app = FastAPI()

# Logika wyciągnięta do funkcji - to będziemy testować jednostkowo
def get_hello_message():
    return {"message": "Hello World"}

@app.get("/")
def read_root():
    return get_hello_message()