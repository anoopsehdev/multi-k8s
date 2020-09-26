docker build -t anoopsehdev/multi-client:latest  -t anoopsehdev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anoopsehdev/multi-server:latest  -t anoopsehdev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anoopsehdev/multi-worker:latest  -t anoopsehdev/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push anoopsehdev/multi-client:latest
docker push anoopsehdev/multi-server:latest
docker push anoopsehdev/multi-worker:latest

docker push anoopsehdev/multi-client:$SHA
docker push anoopsehdev/multi-server:$SHA
docker push anoopsehdev/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=anoopsehdev/multi-client:$SHA
kubectl set image deployments/server-deployment server=anoopsehdev/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=anoopsehdev/multi-worker:$SHA