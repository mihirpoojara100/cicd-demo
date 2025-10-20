# CICD-DEMO

This repository is a small demo application whose primary purpose is to demonstrate setting up a CI/CD pipeline that builds and tests a Python app, publishes a Docker image to Docker Hub, and deploys the image to an AWS EC2 instance.

Key focuses

- CI/CD pipeline: automated build, test, container image build, push to Docker Hub, and optional deploy step to EC2.
- Docker Hub: image naming and tagging strategy used by the pipeline.
- EC2: how the application can be deployed to an EC2 instance (AMI, user-data, and runtime expectations).

Repository layout

- `Dockerfile` — builds the container image for the app.
- `app/` — application source code. The entry point is `app/main.py`.
- `requirements.txt` — runtime Python dependencies.
- `requirements-dev.txt` — development/test dependencies.
- `tests/` — unit tests (example: `tests/test_main.py`).

What the pipeline does (typical)

1. Checkout repository on push or pull request.
2. Create a Python environment and install `requirements-dev.txt`.
# cicd-demo

This repository is a focused demo for setting up a CI/CD pipeline that builds and tests a small Python app, publishes a Docker image to Docker Hub, and demonstrates deployment to an AWS EC2 instance.

Focus areas

- CI/CD pipeline: run tests, build a Docker image, push to Docker Hub, and optionally deploy to EC2.
- Docker Hub: how images are tagged and pushed from CI.
- EC2: simple deployment patterns (pull image and run container, SSM, or AMI-based deployments).

Files of interest

- `Dockerfile` — container build instructions.
- `app/main.py` — application entrypoint used in the demo.
- `requirements.txt` / `requirements-dev.txt` — runtime and dev dependencies.
- `tests/` — unit tests executed by the pipeline.

Typical CI flow

1. Checkout code.
2. Install dev dependencies and run tests (pytest).
3. Build Docker image (docker build).
4. Authenticate to Docker Hub using CI secrets.
5. Tag and push the image to Docker Hub (immutable release tags + optional `latest`).
6. (Optional) Deploy to EC2 by pulling the new image and restarting the service.

Quick local steps (PowerShell)

Create a venv and install dev deps:

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1; pip install -r requirements-dev.txt
```

Run tests:

```powershell
.venv\Scripts\Activate.ps1; pytest -q
```

Build and run the image locally:

```powershell
docker build -t <dockerhub-user>/cicd-demo:local .
docker run -p 8000:8000 <dockerhub-user>/cicd-demo:local
```

CI / secrets notes

- Store Docker Hub username and token in your CI provider as protected secrets.
- If deploying to EC2 via SSH, store a deployment key as a protected secret and limit its scope.
- Prefer using AWS IAM roles or SSM for more secure, auditable deployments.

Next steps (suggested)

- Add a CI workflow file (GitHub Actions, GitLab CI, Azure Pipelines, etc.) that implements the steps above.
- Add a small deploy job that demonstrates pulling the pushed image to an EC2 instance using SSM or SSH.

If you want, I can add a sample GitHub Actions workflow and an example EC2 user-data script to this repo — tell me which CI provider and deployment method (SSH or SSM) you prefer.

---

This README intentionally focuses on the CI/CD, Docker Hub, and EC2 aspects of the project.

This project is a demo. Contributions that make the CI/CD, deployment instructions, or automation clearer are welcome.

License

This repo is provided as-is for demonstration and educational purposes.
This project is a demo. Contributions that make the CI/CD, deployment instructions, or automation clearer are welcome.
