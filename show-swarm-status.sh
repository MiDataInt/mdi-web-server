
# collate and dump information about the nodes and active containers

# list the nodes in the swarm
SEPARATOR="--------------------------------------------------------------------------------"
echo $SEPARATOR
docker node ls
echo $SEPARATOR

# list the services running in the swarm
docker service ls
echo $SEPARATOR

# correlate the node hostname and labels to the swarm ids
# note that server does not necessarily have perl JSON library installed
docker node ls |
tail -n+2 |
awk '{print $1, $2}' | # yields a stream of Docker Swarm node ids + hostnames
perl -e '
print join("\t", qw(ID HOSTNAME STATUS LABEL)), "\n";
while(my $line = <STDIN>){
    chomp $line;
    my ($node, $hostname) = split(/\s+/, $line);
    my $nodeData = qx|docker node inspect $node|;
    my ($nodeId, $hostname, $state) = ("---") x 4;
    my @labels;
    $nodeData =~ m/"ID":\s*"(\w+?)",/ and $nodeId = $1;    
    $nodeData =~ m/"Hostname":\s*"(.+?)",/ and $hostname = $1;    
    $nodeData =~ m/"State":\s*"(\w*?)"/ and $state = $1;
    $nodeData =~ m/swarm-manager-node/ and push @labels, "swarm-manager-node";
    $nodeData =~ m/web-server-node/    and push @labels, "web-server-node";
    $nodeData =~ m/app-server-node/    and push @labels, "app-server-node";
    print join("\t", $nodeId, $hostname, $state, join(",", @labels)), "\n";
}
'
echo $SEPARATOR

#[ # abbreviated to the fields we need
#    {
#        "ID": "p0vxkkdf7lz57ibppnrox2f9l",
#        "Spec": {
            #"Labels": {
            #    "swarm-manager-node": "true"
            #    "web-server-node": "true"
            #    "app-server-node": "true"
            #},
#            "Role": "worker",
#            "Availability": "active"
#        },
#        "Description": {
#            "Hostname": "ip-172-30-0-188",
#        },
#        "Status": {
#            "State": "ready",
#        }
#    }
#]

