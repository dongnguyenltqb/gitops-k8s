# Install with Helm

1.  Install Cert Manager

    ```
    helm install \
    cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --create-namespace \
    --version v1.10.1 \
    --set installCRDs=true
    ```

2.  Install CRD

    ```
    helm install linkerd-crds linkerd/linkerd-crds -n linkerd --create-namespace
    ```

3.  Generate Certificate

    ```
    $ step certificate create root.linkerd.cluster.local ca.crt ca.key --profile root-ca --no-password --insecure --not-after=876000h
    $ step certificate create identity.linkerd.cluster.local issuer.crt issuer.key --profile intermediate-ca --not-after 87600h --no-password --insecure --ca ca.crt --ca-key ca.key
    ```

4.  Install Control Plane

    ```
    helm install linkerd-control-plane -n linkerd \
    --set-file identityTrustAnchorsPEM=ca.crt \
    --set-file identity.issuer.tls.crtPEM=issuer.crt \
    --set-file identity.issuer.tls.keyPEM=issuer.key \
    --set proxyInit.runAsRoot=true \
    linkerd/linkerd-control-plane --atomic
    ```

5.  Install Viz

    ```
    $ helm repo add grafana https://grafana.github.io/helm-charts
    $ helm upgrade -i grafana -n grafana --create-namespace grafana/grafana \
     -f https://devops-terraform-assets.s3.ap-southeast-1.amazonaws.com/linkerd-viz-grafana-chart/values.yaml
    $ helm upgrade -i linkerd-viz --set grafana.url=grafana.grafana:80 --set prometheus.enable=true linkerd/linkerd-viz -n linkerd
    ```

6.  Install Flagger

    ```
    helm repo add flagger https://flagger.app
    helm repo update
    helm upgrade -i flagger flagger/flagger \
    --namespace=linkerd \
    --set crd.create=false \
    --set meshProvider=linkerd \
    --set metricsServer=http://linkerd-prometheus:9090 --atomic
    ```
