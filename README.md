1. The statefulset-no-helm contains the yaml that deploys a statefulset with a persistence volume claim defined in volumeClaimTemplate. The PV will be created dynamcally using the storage class. use kubectl apply -f statefulset.yaml to deploy.

2. The nginx-chart directory contains the statefulset packaged as helm chart. The **values.yaml** contains some variables we can use to to update the statefulset deployment. The templates directory contains the resource definition (statefulset.yaml). To install this chart, use: **helm install frontend nginx-chart**

3. The helmfile.yaml file, this file allows us to deploy our helm chart in a declarative way, we can also override some variables usinf set. This helmfile install our chart in two environments, each with different namespace and replicaCount. Use **helmfile apply** to install this chart.

4. In the scripts directory, there is a file **bash_script.sh**, this shell script uses grep, awk, sort and uniq to parse a log file, retrives the IP address and their occurrences, then output to a CVS file.

5. In the scripts directory, there is a file - python_script.py, this scripts uses re and cvs modules, the re module is used to capture the IP address pathern in the logs and write to the CVS file **output.csv**

6. The terraform directory contains a terraform scripts that create a an IAM role that can be assumed by any user in the account. The data source allows us to retreive all users in the account. The principal in the role referenced tha data. Users are created using set of variables and are added to a group, the group has a policy that allows it to assume the IAM role. I used for_each meta-argurment to loop through user list which was passed a variable.

7. I'm not too familiar with fluxcd, but I know it's like ArgoCD for gitops, this tool will allow us to sync our k8s manifest from github repository to the cluster. The bootstrap will require us to specify the source repository and target clucster.

8. I haven't used fluxcd before but using ArgoCD, when we update our releases and push to our repository, this should sync our update to the k8s cluster.

9. I'm not used to tekton pipeline, but I know how to use github action and Jenkins for CI. This setup will use a custom dockerfile and build an image with a tag, then push to the registry. This will involve having multiple stages in the pipeline (pull >> build >> push)


References:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

https://helmfile.readthedocs.io/en/latest/

https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

https://www.w3schools.com/python/python_regex.asp

https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_permissions-to-switch.html
