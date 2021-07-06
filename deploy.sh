docker build -t sumitchandnani/multi-client:latest -t sumitchandnani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sumitchandnani/multi-server:latest -t sumitchandnani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sumitchandnani/multi-worker:latest -t sumitchandnani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sumitchandnani/multi-client:latest
docker push sumitchandnani/multi-server:latest
docker push sumitchandnani/multi-worker:latest

docker push sumitchandnani/multi-client:$SHA
docker push sumitchandnani/multi-server:$SHA
docker push sumitchandnani/multi-worker:$SHA

kubectl apply -f K8s
kubectl set image deployments/server-deployment server=sumitchandnani/multi-server:$SHA
kubectl set image deployments/client-deployment client=sumitchandnani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sumitchandnani/multi-worker:$SHA


