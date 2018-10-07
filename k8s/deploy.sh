docker build -t gustavolee/multi-client:latest -t gustavolee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gustavolee/multi-server:latest -t gustavolee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gustavolee/multi-worker:latest -t gustavolee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gustavolee/multi-client:latest
docker push gustavolee/multi-server:latest
docker push gustavolee/multi-worker:latest

docker push gustavolee/multi-client:$SHA
docker push gustavolee/multi-server:$SHA
docker push gustavolee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gustavolee/multi-server:$SHA
kubectl set image deployments/client-deployment client=gustavolee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gustavolee/multi-worker:$SHA
