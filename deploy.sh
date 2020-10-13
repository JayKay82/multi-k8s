docker build -t jaykay82/multi-client:latest -t jaykay82/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jaykay82/multi-server:latest -t jaykay82/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jaykay82/multi-worker:latest -t jaykay82/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jaykay82/multi-client:latest
docker push jaykay82/multi-server:latest
docker push jaykay82/multi-worker:latest

docker push jaykay82/multi-client:$SHA
docker push jaykay82/multi-server:$SHA
docker push jaykay82/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jaykay82/multi-client:$SHA
kubectl set image deployments/server-deployment server=jaykay82/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jaykay82/multi-worker:$SHA
