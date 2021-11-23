#!/bin/bash

# called within the docker-access AWS instance (i.e. Swarm Manager) to execute
# 'update-app-server.sh' in all running app-server worker instances

docker node ls |
tail -n+2 |
awk '{print $1, $2}' | # yields a stream of Docker Swarm node ids + hostnames
perl -e '
while(my $line = <STDIN>){
    chomp $line;
    my ($node, $hostname) = split(/\s+/, $line);
    my $nodeData = qx|docker node inspect $node|;
    if($nodeData =~ m/app-server-node/){
        print "=" x 50, "\n";
        print $hostname, "\n";
        print "-" x 50, "\n";
        system("ssh -i ~/.ssh/magc-portal-rsa $hostname bash update-app-server.sh")
    }
}
print "=" x 50, "\n";
'

