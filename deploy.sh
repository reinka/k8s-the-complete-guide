docker build -t apoehlmann/multi-client:latest -t apoehlmann/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t apoehlmann/multi-server:latest -t apoehlmann/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t apoehlmann/multi-worker:latest -t apoehlmann/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push apoehlmann/multi-client:latest
docker push apoehlmann/multi-server:latest
docker push apoehlmann/multi-worker:latest
docker push apoehlmann/multi-client:$SHA
docker push apoehlmann/multi-server:$SHA
docker push apoehlmann/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=apoehlmann/multi-server:$SHA
kubectl set image deployments/client-deployment server=apoehlmann/multi-client:$SHA
kubectl set image deployments/worker-deployment server=apoehlmann/multi-worker:$SHA
