docker build -t jaykay82/multi-client:latest -t jaykay82/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jaykay82/multi-server:latest -t jaykay82/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jaykay82/multi-worker:latest -t jaykay82/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push jaykay82/multi-client:latest
docker push jaykay82/multi-server:latest
docker push jaykay82/multi-worker:latest

docker push jaykay82/multi-client:$GIT_SHA
docker push jaykay82/multi-server:$GIT_SHA
docker push jaykay82/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jaykay82/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=jaykay82/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=jaykay82/multi-worker:$GIT_SHA
