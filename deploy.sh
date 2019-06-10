docker build -t bondar5471/multi-client:latest -t bondar5471/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bondar5471/multi-server:latest -t bondar5471/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t bondar5471/multi-worker:latest -t bondar5471/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bondar5471/multi-client:latest
docker push bondar5471/multi-server:latest
docker push bondar5471/multi-worker:latest

docker push bondar5471/multi-client:$SHA
docker push bondar5471/multi-server:$SHA
docker push bondar5471/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bondar5471/multi-server:$SHA
kubectl set image deployments/client-deployment client=bondar5471/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bondar5471/multi-worker:$SHA
