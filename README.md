# V_A_D_W_G

A local IAC construct allowing for various development and test scenarios to take place.  
Included for enjoyment is a Go app demonstrating load balancing via Weave and how outrageously small a microservice could be made.

## Prerequisites

Vagrant, Vagrant-Cachier plugin, VirtualBox, and VirtualBox Extension Pack installs.

https://www.vagrantup.com/downloads.html  
https://www.virtualbox.org/wiki/Downloads

## Usage

Run the following from repo root -

`vagrant up`

Highly recommend viewing the Vagrant site for more information.

## Description

Briefly -

<b>1</b>. Spins up 4 Ubuntu VM's - an ACM and 3 target VM's, the first target being used for builds, the second for the environment proper, and the third for test scenarios.  
<b>2</b>. Installs Ansible for the ACM.  
<b>3</b>. Runs an ACM site playbook for all targets named: Target1, Target2 and Target3.  
<b>4</b>. Installs a Docker engine and any fixes for all targets.  
<b>5</b>. Makes a private local Docker image registry so we can push/pull/store our dev/test images (Target 1).  
<b>6</b>. Installs and launches a Weave net to provide for container network orchestration/SDN capability upon all targets.  
<b>7</b>. Pulls the Go source (a clone and a checkout) and compiles to v1.7 starting at the chain source bootstrap v1.4 - allows for easy creation of static Go binaries (Target1).  
<b>8</b>. Sets up the Go workspace and retrieves dependencies - namely the gorilla (Target1).  
<b>9</b>. Moves our Go app source to the Go workspace (Target1).  
<b>10</b>. Makes a compact static Go binary (a REST based service - Target1).  
<b>11</b>. Sets up the directory and file structure needed for the creation of Docker images (Target1).  
<b>12</b>. Creates an empty Docker base image and bakes in our recently made static Go binary (Target1).  
<b>13</b>. Tags and pushes the newly created REST service Docker image to the local Docker registry.  
<b>14</b>. Runs our REST service containers upon Target1 and Target2 via the registry - 3 per VM.  
<b>15</b>. Performs tests starting with the output to log files of the status of Weave upon all targets.  
<b>16</b>. Pulls a base Ubuntu Docker image from the online hub and bakes in our test script.  
<b>17</b>. Tags and pushes the Docker image to be used for test purposes to the local Docker registry.  
<b>18</b>. Runs the test container via the registry addition and hits the test script within the container to output the results to a log file (Target3).

## Tests -

<b>1</b>. The status of Weave may be viewed upon all targets via log -

`/var/log/weave_status.log`

Example output (Target1) -

```
        Version: 2.0.5 (up to date; next check at 2017/10/29 22:41:26)

        Service: router
       Protocol: weave 1..2
           Name: ee:3b:55:53:a8:83(vagrant)
     Encryption: disabled
  PeerDiscovery: enabled
        Targets: 0
    Connections: 2 (2 established)
          Peers: 3 (with 6 established connections)
 TrustedSubnets: none

        Service: ipam
         Status: ready
          Range: 10.10.0.0/24
  DefaultSubnet: 10.10.0.0/24

        Service: dns
         Domain: weave.local.
       Upstream: 10.0.2.3, 127.0.0.53
            TTL: 1
        Entries: 6

        Service: proxy
        Address: unix:///var/run/weave/weave.sock

        Service: plugin (legacy)
     DriverName: weave

loadbalance  10.10.0.3       7ac8b3d1c83c ee:3b:55:53:a8:83
loadbalance  10.10.0.1       a565f2878f91 ee:3b:55:53:a8:83
loadbalance  10.10.0.2       c8fa5c2b48af ee:3b:55:53:a8:83
loadbalance  10.10.0.192     049fc0d3ab38 fa:ad:1e:1b:86:c2
loadbalance  10.10.0.193     395daf3c5183 fa:ad:1e:1b:86:c2
loadbalance  10.10.0.194     c8f7ddf8caad fa:ad:1e:1b:86:c2
```

<b>2</b>. Test script output to show the status of load balancing may be found here (Target3) -

`/var/log/lb_test.log`

Attach yourself -

`docker exec -ti handy_testy /bin/bash`

Typical output to show that load balancing is working fine would be similar to -

```
10.10.0.194

10.10.0.3

10.10.0.193

10.10.0.194

10.10.0.192

10.10.0.3

10.10.0.192

10.10.0.193

10.10.0.1

10.10.0.194

10.10.0.2

10.10.0.192

10.10.0.192

10.10.0.1

10.10.0.3

10.10.0.193

10.10.0.1

10.10.0.1

10.10.0.2

10.10.0.3
```

## Notes -

:small_orange_diamond: Subsequent spinning up of the environment following the initial build out is much speedier due to local caching.  
:small_orange_diamond: The Vagrant-Cachier plugin does not appear to be maintained, some buginess may develop as time progresses.
