```bash
SB5J61TpiwLXRgPxKek0BjYAdKp27DCwfjtCCLWo
```
###  1. **Get your 'admin' user password by running:**

   kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo


### 2. **The Grafana server can be accessed via port 80 using kubectl port-forward:**
```bash
kubectl port-forward svc/grafana 3000:80 -n  monitoring
```