# all mounts should be made to a sub-directory of /srv/mnt
# example for AWS EFS:
#    sudo mkdir -p /srv/mnt/efs
#    sudo mount -t efs -o tls fs-12345678:/ /srv/mnt/efs
# mounts will be available in the apps server under the same path
