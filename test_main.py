from fastapi.testclient import TestClient
from main import app, get_hello_message

client = TestClient(app)

# --- TEST JEDNOSTKOWY (Unit Test) ---
# Testujemy samą funkcję, bez udziału FastAPI i HTTP
def test_get_hello_message():
    result = get_hello_message()
    assert result == {"message": "Hello World"}
    assert isinstance(result, dict) # Sprawdzamy czy to na pewno słownik (JSON)

# --- TEST INTEGRACYJNY (Integration Test) ---
# Testujemy czy endpoint poprawnie współpracuje z funkcją i zwraca 200 OK
def test_read_main_endpoint():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}