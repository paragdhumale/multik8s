docker build -t paragdhumale/multi-client:latest -t paragdhumale/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paragdhumale/multi-server:latest -t paragdhumale/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paragdhumale/multi-worker:latest -t paragdhumale/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push paragdhumale/multi-client:latest
docker push paragdhumale/multi-server:latest
docker push paragdhumale/multi-worker:latest
docker push paragdhumale/multi-client:$SHA
docker push paragdhumale/multi-server:$SHA
docker push paragdhumale/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paragdhumale/multi-server:$SHA
kubectl set image deployments/client-deployment client=paragdhumale/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paragdhumale/multi-worker:$SHA