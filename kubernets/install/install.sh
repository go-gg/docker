kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-cert-extra-sans=47.111.68.174

#letsencrypt
./certbot-auto certonly --preferred-challenges dns --manual -d *.baifm.cn --server https://acme-v02.api.letsencrypt.org/directory
./certbot-auto certonly --preferred-challenges dns --manual -d unionpay.test.msjiay.com

#get
kubectl get pod,svc,ingress -o wide -n kube-system

#basic-auth
kubectl delete -f ./basic-auth.yaml
kubectl apply -f ./basic-auth.yaml

#traefik
kubectl create secret tls baifm.cn-tls --key=1573913__baifm.cn.key --cert=1573913__baifm.cn.pem -n kube-system
kubectl delete secret baifm.cn-tls -n kube-system

kubectl delete -f ./traefik-ui.yaml
kubectl delete -f ./traefik-ds.yaml
kubectl delete -f ./traefik-rbac.yaml 

kubectl delete -f ./traefik-deployment.yaml

kubectl apply -f ./traefik-rbac.yaml 
kubectl apply -f ./traefik-ds.yaml
kubectl apply -f ./traefik-ui.yaml

kubectl apply -f ./traefik-deployment.yaml

#dashboard
kubectl delete -f ./dashboard.yaml
kubectl apply -f ./dashboard.yaml

kubectl create secret tls baifm.cn-tls --key=1573913__baifm.cn.key --cert=1573913__baifm.cn.pem -n kubernetes-dashboard
kubectl delete secret baifm.cn-tls -n kubernetes-dashboard

kubectl delete -f ./dashboard-ingress.yaml
kubectl apply -f ./dashboard-ingress.yaml

kubectl delete -f ./dashboard-admin.yaml
kubectl apply -f ./dashboard-admin.yaml

kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep dashboard-admin | awk '{print $1}')

eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkYXNoYm9hcmQtYWRtaW4tdG9rZW4temRuNmciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGFzaGJvYXJkLWFkbWluIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiMmIzZWM2YjAtZGRjMy00MjczLTg0NTEtN2I1YjY4ZGM2ZTBmIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmVybmV0ZXMtZGFzaGJvYXJkOmRhc2hib2FyZC1hZG1pbiJ9.kUTQK6TyOOH039OiYWHMjjn8JHwAS448MtD_a9P69XxdkvD8N127Q6bv6zrjjdXtok0PZjWduUpfWvcEONTFwz5v-kGePPD4Cu4TMuzOPhMDmN5LmU8mbDi8wAUXT0zY8EwDDaskpBp-kWvJZ3M0EIBxSNUHYEmFm1fc8HYwkPt6KQH6IY4MTX6BvLr7AwE2a5HpiWjTkODjf1dnYMzrG7ZeFcK5XBBXodzjiIQse2efMGMhouwg44ldrzgVEQRcPjdazWkWILUobinc-IIElNcZZzH3DVVgdUxLI_H3lHkdvJVBBHl5EhMY3UibgKQpInSmHtVoPZRxd07GyDUkQw

#namespace
kubectl delete -f ./winner-test.yaml
kubectl apply -f ./winner-test.yaml

kubectl create secret tls baifm.cn-tls --key=1573913__baifm.cn.key --cert=1573913__baifm.cn.pem -n winner-test
kubectl delete secret baifm.cn-tls -n winner-test

#whoami
kubectl delete -f ./whoami.yaml
kubectl apply -f ./whoami.yaml

#dns
whoami.winner-test.svc.cluster.local
dig @10.96.0.10 whoami.winner-test.svc.cluster.local

#helm
kubectl delete -f ./helm-rbac.yaml
kubectl apply -f ./helm-rbac.yaml

helm init --service-account tiller --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.2 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
helm init --service-account tiller --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.2 --tiller-tls-cert /etc/kubernetes/ssl/tiller001.pem --tiller-tls-key /etc/kubernetes/ssl/tiller001-key.pem --tls-ca-cert /etc/kubernetes/ssl/ca.pem --tiller-namespace kube-system --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts


#gitlab
#https://docs.gitlab.com/ee/user/project/clusters/

kubectl get secrets
kubectl get secret default-token-4cljb -o jsonpath="{['data']['ca\.crt']}" | base64 --decode


kubectl apply -f gitlab-admin-service-account.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep gitlab-admin | awk '{print $1}')

https://47.111.68.174:6443
https://172.16.129.139:6443
-----BEGIN CERTIFICATE-----
MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
cm5ldGVzMB4XDTE5MDcyOTA0MzAxNloXDTI5MDcyNjA0MzAxNlowFTETMBEGA1UE
AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK0E
w1LdMQeHJ6k9VOKKotp+YK0XYX3wiWJnwU6ahIXNqIy/YK/X7wkhrn+2sDRxhGlt
79BTlzlQMfQsR3IgVyAUOPUz/AlRzL5zpNIuv3Knyb4FTVGgwjhXdw1ga6kZjFL5
aIvcHRSxDiT6uMMweN4alBdia1zjZAvd66SnSS3HtQajRtF5k2MITGNiyKplG+Ch
8w5tPrNe/uY2XeM2UFuUjpfHEV9angSniWONuHSwJndCzHi67CPD9lZploRiKJGS
ybE6aR7fd7w0IoQ8PMu9BJXWgqzXXoVVTQfTLf/aP0CUnwUtTn6LicFzu9OF1gHU
ITWuOg8gKtHeE6WWIeUCAwEAAaMjMCEwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB
/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBACpnwWXWmyyKRdQHsx+fIXcbCKw3
YiCeqXvQABSfTAxAmnu0TnDBJdx3LojjZYVMEGruRz7ZmS2rk+crds0KTLsvHXf4
3bXyK9T3zqzmStrU783Y1VVOhFteRGhVlJdOm8xm81BcgdV5qK1sFiIbK02F1Gr1
uEMP0PNpDlPDeXrIQMTLCMyEgxP7zgaaRjDL4gygm68nWqLgwb4vdyHfQ7RPz9uj
7JID9Pd2w8HyBufJxWxUNib3BA29uifCEcHUNebc2fsXhMjNVe6CvtfleCMUU98i
Hlph73UWXiYZH986wKj218nl8tVKvwp+Ar+dhdv5oVU6kRsINRNNAV/Uq4M=
-----END CERTIFICATE-----

eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJnaXRsYWItYWRtaW4tdG9rZW4tN2JsamYiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZ2l0bGFiLWFkbWluIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOGFjMmM4NWEtYTU2Mi00ZDJiLTkzN2EtYTA4ZmM1Mzk0ZmUwIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOmdpdGxhYi1hZG1pbiJ9.SXdrZ_4dDgMnI8Rjn_77zm-yX0JnqidJjhLwYgBEwYU4pW8dwNwDZ4ZtDqGmiHayTTUmOyEUsFCgoW6UROEi0PUc3-M7I7U8wlQ6Yk-Fo5HFdO6uPKi966iFHlqFF2nJYi8kLdnzrupuy0vIQFfUhzd3pDNaWcg7YwJ2T49GdYiMURMevGde5ycVHg-ePpL3KobYYMj34aAb3WSllya5horVd4wlkX-bDFVBHlCjIb2Sx-Ore0biDbNyXMQWk9pAPsAdJ7zcFHc3WF_z5HTHpXCe35IETI_8pNUFcGlGNtPHup8geP-d5Wm_3Gudh6CxDurig8D0W9VvbOXsXtqGDQ

curl https://47.111.68.174:6443/api/v1
curl -k -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJnaXRsYWItYWRtaW4tdG9rZW4tN2JsamYiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZ2l0bGFiLWFkbWluIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOGFjMmM4NWEtYTU2Mi00ZDJiLTkzN2EtYTA4ZmM1Mzk0ZmUwIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOmdpdGxhYi1hZG1pbiJ9.SXdrZ_4dDgMnI8Rjn_77zm-yX0JnqidJjhLwYgBEwYU4pW8dwNwDZ4ZtDqGmiHayTTUmOyEUsFCgoW6UROEi0PUc3-M7I7U8wlQ6Yk-Fo5HFdO6uPKi966iFHlqFF2nJYi8kLdnzrupuy0vIQFfUhzd3pDNaWcg7YwJ2T49GdYiMURMevGde5ycVHg-ePpL3KobYYMj34aAb3WSllya5horVd4wlkX-bDFVBHlCjIb2Sx-Ore0biDbNyXMQWk9pAPsAdJ7zcFHc3WF_z5HTHpXCe35IETI_8pNUFcGlGNtPHup8geP-d5Wm_3Gudh6CxDurig8D0W9VvbOXsXtqGDQ" https://47.111.68.174:6443/api

#gitlab-tiller
docker pull sapcc/tiller:v2.12.3
docker tag sapcc/tiller:v2.12.3 gcr.io/kubernetes-helm/tiller:v2.12.3

helm install --namespace gitlab-runner --name gitlab-runner -f ./gitlab-runner.yaml gitlab/gitlab-runner
helm delete gitlab-runner