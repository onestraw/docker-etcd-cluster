CID_FILE = /tmp/onestraw-etcd-cluster.cid
CID =`cat $(CID_FILE)`
IMAGE_NAME = onestraw/etcd-cluster
PORTS = -p 2376:2376 -p 2377:2377 -p 2378:2378 -p 2379:2379 -p 2380:2380 -p 2381:2381 -p 2382:2382 -p 2383:2383

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  build           build the docker image containing a etcd cluster"
	@echo "  rebuild         rebuilds the image from scratch without using any cached layers"
	@echo "  run             run the built docker image"
	@echo "  bash            starts bash inside a running container."
	@echo "  stop			 stops the built docker image"
	@echo "  clean           removes the tmp cid file on disk"

build:
	@echo "Building docker image..."
	docker build -t ${IMAGE_NAME} .

rebuild:
	@echo "Rebuilding docker image..."
	docker build --no-cache=true -t ${IMAGE_NAME} .

run:
	@echo "Running docker image..."
	docker run -d $(PORTS) --cidfile $(CID_FILE) -i -t ${IMAGE_NAME}

bash:
	docker exec -it $(CID) sh

stop:
	docker stop $(CID)
	-make clean

clean:
	# Cleanup cidfile on disk
	-rm $(CID_FILE)
