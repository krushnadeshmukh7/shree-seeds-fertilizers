# Shree Seeds & Fertilizers

Starter DevOps project containing:
- Spring Boot + Thymeleaf
- MySQL configuration
- Docker
- Kubernetes manifests
- Terraform starter
- Jenkinsfile (application CI/CD)
- Jenkinsfile-infra (Terraform infrastructure pipeline)

## Important
Before deployment, update:
1. ECR image in `k8s/deployment.yaml`
2. RDS endpoint in `k8s/configmap.yaml`
3. DB credentials in `k8s/secret.yaml`
4. EKS cluster name/region in `Jenkinsfile`
5. Terraform backend bucket if needed

## Local run
mvn clean package
java -jar target/shree-seeds-fertilizers-1.0.0.jar

## Terraform EKS
Region: us-west-2 | Cluster: shree-seeds-eks | Nodes: 2 x c7i-flex.large

```bash
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
aws eks update-kubeconfig --region us-west-2 --name shree-seeds-eks
kubectl get nodes
```
AWS resources can incur charges. Use `terraform destroy` when finished.
