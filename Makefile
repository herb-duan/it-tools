# 变量定义
IMAGE_NAME = it-tools
DOCKER_REGISTRY = ccr.ccs.tencentyun.com/herbduan
COMMIT_HASH = $(shell git rev-parse --short HEAD)
DATE = $(shell date +%Y%m%d)
VERSION = $(DATE)-$(COMMIT_HASH)

.PHONY: build push deploy

# 构建Docker镜像
build:
	docker build -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) .

# 推送到私有仓库
push:
	docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION)

# 部署到K3s
deploy:
	kubectl apply -f k8s/

# 构建并部署
all: build push deploy 