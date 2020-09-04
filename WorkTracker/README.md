# WorkTracker
Your Module description here...
## What does my Module
...
## How to use my Module
...
## Examples
...
## Deployment
If you'd like to deploy this module to the nexus, to make it available for everyone else, it is really simple.
There was a _Jenkinsfile_ created for you in the root directory. This _Jenkinsfile_ contains all the information
needed by the jenkins to build, test and deploy your module. Simply follow these steps:
* Create a git repository and push your module
* [Go to the jenkins and create a new *Multibranch Pipeline* job](http://192.168.1.7:8080/view/all/newJob)
* Choose your Git repository as *Branch Source*
* Hit *Save* and your done.
