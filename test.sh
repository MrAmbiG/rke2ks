if [[ "1.23.16" == "$1" ]]; then
    k8s_version="v1.23.16+rke2r1"
    echo "selected k8s version: $k8s_version"
elif [[ "1.24.10" == "$1" ]]; then
    k8s_version="v1.24.10+rke2r1"
    echo "selected k8s version: $k8s_version"
elif [[ "1.25.6" == "$1" ]]; then
    k8s_version="v1.25.6+rke2r1"
    echo "selected k8s version: $k8s_version"
else
   k8s_version="v1.26.1+rke2r1"
   echo "selected k8s version: $k8s_version"
fi