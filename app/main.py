from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator
from pydantic import BaseModel


app = FastAPI(
    title="IronLatch API",
    version="1.1.0",
)
Instrumentator().instrument(app).expose(
    app,
    endpoint="/metrics",
    include_in_schema=False,
)


class DeploymentRequest(BaseModel):
    name: str
    version: str
    environment: str


@app.get("/health")
def health():
    return {"status": "healthy"}


@app.get("/api/info")
def info():
    return {
        "name": "IronLatch API",
        "version": "1.1.0",
    }


@app.post("/deployments")
def create_deployment(deployment: DeploymentRequest):
    return deployment