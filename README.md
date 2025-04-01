# argocd
admin / 6dea16e5-a9e3-4d1e-9d1a-c4a984fea37e
# DATX K8S Production 01

# Dremio
https://www.dremio.com/blog/a-notebook-for-getting-started-with-project-nessie-apache-iceberg-and-apache-spark/
https://www.dremio.com/blog/deep-dive-into-configuring-your-apache-iceberg-catalog-with-apache-spark/

This repo contains all helm charts that will be deployed to DATX K8S Production Cluster

Gitlab Deployer Token: xkYB7LKixvyL4U5gssRs

git clone https://deployer:xkYB7LKixvyL4U5gssRs@git.datx.com.vn/datx-k8s/k8s-prod01.git
Nodeport

List Node Port:

- Core service: 32xxx
- Project service: 31xxx

Core service

- 32001: Longhorn UI
- 32002: Longhorn Manager
- 32003: Argo CD / admin / 0fyQVm7sC7
- 32004: Kubernetes Dashboard 
- 32005: Vault UI / 

vault operator init 

    Unseal Key 1: 5yXw/uY1CmHcpEzbK/K68QllbU1P5A3p5Mt3EFILs5yC
    Unseal Key 2: w22EZsOxFRZRhNUCYru5/utLKZkusK7N5xCDyXgcJXt1
    Unseal Key 3: wqGTyKZw1KJv2rw/V87oEYsiEGtjd+6YfowAGPX60DTJ
    Unseal Key 4: z7IKpVugD5NitGMIIbfzRv9POcRJhscF29HowVOoTkyn
    Unseal Key 5: 2wUwyKAgvuG3hgkidKC31X0WlZy4U3cimqXBI5q0BHbw

    Initial Root Token: hvs.7rr5JWXfCXCKwT7KD7i1zpgH

vault operator unseal 2wUwyKAgvuG3hgkidKC31X0WlZy4U3cimqXBI5q0BHbw 
vault operator unseal 2wUwyKAgvuG3hgkidKC31X0WlZy4U3cimqXBI5q0BHbw 
vault operator unseal 2wUwyKAgvuG3hgkidKC31X0WlZy4U3cimqXBI5q0BHbw 

Vault VM:
```
- URL: http://10.0.129.10:8200

- Unseal Key 1: 5oOM8byRw1Kvvbwmq2FH/PX5pWHPeigBZOsKH00LAmR4
- Unseal Key 2: pMGnHFe1qPRQoLpjEoNpZz+KnuUCiGlk5q2NWRZqrFFA
- Unseal Key 3: z4YlvRC9GSFSZbbJBIJBqvWARj+valJ51Um6EuncT+y4
- Unseal Key 4: q9ReMdtl0GSme/ABIV9YzNBoQ2TlJF8vOBEUvKViarD/
- Unseal Key 5: Bet3zqJVwhOYS+EBtVct9uZ2mN3Kn29iSxfRPnJLMX6x

- Initial Root Token: hvs.yEWFDzqFy0fpM1405BAUP4Oq
```
Config Vault env:
```shell
sudo tee -a ~/.bashrc<<EOF
#Vault
export VAULT_ADDR='http://10.0.129.10:8200'
export VAULT_TOKEN='hvs.yEWFDzqFy0fpM1405BAUP4Oq'
EOF
source ~/.bashrc
```

Create ENV Read Policy
```shell
vault policy write env-read -<<EOF
path "prod-projects-secrets/*" {
    capabilities = ["read", "list"]
}
path "beta-projects-secrets/*" {
    capabilities = ["read", "list"]
}
EOF
```
Create ENV Write Policy
```shell
vault policy write env-write -<<EOF
path "prod-projects-secrets/*" {
    capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
path "beta-projects-secrets/*" {
    capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
EOF
```


Vault VM Env Read token:
```
root@datx-prod-vault01:~# vault token create -policy=env-read -ttl=3650d
Key                  Value
---                  -----
token                hvs.CAESIEQ6GggFxwdyWH0BNUA8stJeGiae_wpgyYoVcJZ3c0eYGh4KHGh2cy5Hd05JTnFoMnVHS3lJUUo5a0V3SEZaMkI
token_accessor       AjVxE4IfYiiEUzBJ1hQYHSvl
token_duration       87600h
token_renewable      true
token_policies       ["default" "env-read"]
identity_policies    []
policies             ["default" "env-read"]

```
Vault VM Env Write token:
```
root@datx-prod-vault01:~# vault token create -policy=env-write -ttl=3650d
Key                  Value
---                  -----
token                hvs.CAESIKGT7ZQblfgq8l9o9kHP9wL-r1O9gvzgVAUNXph9M9YIGh4KHGh2cy5SalFOckV6TEN4Tk00N0p6VUJ2S0hTQmk
token_accessor       hDyteglqDDaoWhUD7TKMV4N2
token_duration       87600h
token_renewable      true
token_policies       ["default" "env-write"]
identity_policies    []
policies             ["default" "env-write"]
```

vault login ...

vault token create 

    Deployer Token: hvs.VM8bci9uRrvdffWcKNaILcNQ

- 32006: Alert manager
- 32007: Alert manager replica

- 32008: Prometheus
- 32009: Prometheus replica

- 32010: Grafana


Project service

- beta-tradingview                   31001
- beta-tradingview-wrapper           31002
- beta-trading-view-api              31003
- beta-xwealth-platform-v1           31004

- main-tradingview                31101
- main-tradingview-wrapper        31102
- main-trading-view-api           31103
- main-xwealth-platform-v1        31104

- vix-main-xwealth-platform-v1            31204




