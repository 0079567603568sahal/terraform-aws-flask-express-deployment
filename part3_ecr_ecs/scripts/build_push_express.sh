#!/usr/bin/env bash
set -euo pipefail

AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID:-}
AWS_REGION=${AWS_REGION:-ap-south-1}
REPO=${REPO:-express-frontend-repo}
TAG=${TAG:-latest}

if [ -z "$AWS_ACCOUNT_ID" ]; then
  echo "Export AWS_ACCOUNT_ID before running. Example: export AWS_ACCOUNT_ID=123456789012"
  exit 1
fi

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build
docker build -t express-frontend-repo ../../apps/express_app


# Create repo if not exists (safe)
aws ecr describe-repositories --region $AWS_REGION --repository-names $REPO >/dev/null 2>&1 || \
  aws ecr create-repository --region $AWS_REGION --repository-name $REPO

docker tag ${REPO}:${TAG} $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${REPO}:${TAG}
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${REPO}:${TAG}
echo "Pushed $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${REPO}:${TAG}"
