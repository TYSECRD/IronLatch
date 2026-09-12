from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_health():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}


def test_info():
    response = client.get("/api/info")

    assert response.status_code == 200
    assert response.json() == {
        "name": "IronLatch API",
        "version": "1.1.0",
    }


def test_create_deployment():
    payload = {
        "name": "ironlatch-api",
        "version": "1.1.0",
        "environment": "development",
    }

    response = client.post("/deployments", json=payload)

    assert response.status_code == 200
    assert response.json() == payload


def test_metrics():
    response = client.get("/metrics")

    assert response.status_code == 200
    assert "http_requests_total" in response.text