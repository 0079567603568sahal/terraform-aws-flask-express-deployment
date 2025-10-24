#!/bin/bash
set -euo pipefail

AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:-<AWS_ACCOUNT_ID>}"
AWS_REGION="${AWS_REGION:-ap-south-1}"
REPO_NAME="${REPO_NAME:-flask-backend-repo}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

# login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# build
docker build -t ${REPO_NAME}:${IMAGE_TAG} ./apps/flask_app

# ensure repo exists (terraform should have created it)
aws ecr describe-repositories --repository-names "${REPO_NAME}" --region $AWS_REGION >/dev/null 2>&1 || aws ecr create-repository --repository-name "${REPO_NAME}" --region $AWS_REGION

# tag & push
docker tag ${REPO_NAME}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}

echo "Pushed ${REPO_NAME}:${IMAGE_TAG}"
