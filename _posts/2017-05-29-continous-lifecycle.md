---
title:    Continuous Lifecycle Conference 2017
date:     2017-05-29 20:00:00 +0000
category: post
---
A couple of weeks ago, I went to the second day of [Continuous Lifecycle][clc], a conference about all things Continuous Delivery, Continuous Integration and Continuous &lt;insert word here&gt;.

I've written up some notes of the talks that I went to below - hopefully you might find some of them useful / interesting and sorry if any of them aren't clear.
I thought the conference was good overall and fairly well organised.
I'd recommend it to anyone interested in DevOps stuff!


## [A Culture of Openness][openness] by Jen Krieger - "Chief Agile Architect" at Redhat

* She talked about Redhat trying to move to an agile way of working but how it wasn't successful to start with.
* She mentioned a project which took 18 months rather than the estimated 6 months due to a communication divide between the managers / stakeholders and the devs.
* The key issues leading to the divide (and failure) were: No Visibility => Assumptions => Blame => Silos => No Visibility and so on.
* The correct approach is: Transparency => Open-Minded => Responsibility => Team-oriented.
* Don't try to change others, lead by example - changing others is hard and you can waste your time.
* Also, vote with your feet if you feel the culture makes none of this possible - "it's your fault if you're unhappy or not progressing".


*My thoughts: Sounded a bit like some of the issues that LBG have.*


**TL;DR: People are difficult.**


## [CI/CD in a Serverless World][serverless] by Fernando Honig - a consultant at Contino (a CI/CD consultancy)

* Serverless is supposedly the *Next Big Thing&trade;* - containers were the last *Next Big Thing&trade;* and machine learning is the next *Next Big Thing&trade;*.
* The serverless idea combines functions as a service (e.g. AWS Lambda) with backend as a service (e.g. DynamoDB) to create full applications.
* AWS lambda is one provider with IBM Openwhisk, Azure Functions and Google Cloud Functions providing their own alternatives.
* Serverless is supposedly cheaper as you only pay for execution rather than paying to keep the server running.
He used [this][serverless-calc] to show some prices.
* He showed an example serverless app with the static assets hosted in an S3 bucket which called a Lambda to get some data.
* He talked about how you can have different environments (e.g. prod, test, dev) by using different versions of the same Lambda (e.g. v6 = dev, v5 = test, v4 = prod) with the config being stored in environment variables, S3 or DynamoDB.
* Having all your logic in lambdas makes it harder to test due having to mock so many other lambdas.
Integration testing sounds better but would cost money.
* He then showed an example of a CD pipeline using AWS Lambda and S3.
* Each build step is a single Lambda with S3 being used to pass zips of the code between the different steps (and also trigger subsequent steps).


*My thoughts: The different versions for different environments thing seemed mad and is also against AWS best practices of having different accounts for different environments.
I've used Lambdas before for thumbnail generation on uploading an image which was neat but using it for your CD pipeline sounds crazy.*


**TL;DR: Serverless seems cool and is supposedly the *Next Big Thing&trade;*.**


## [openQA: Avoiding Disasters of Biblical Proportions][openqa] by Marita Werner - openSUSE QA PM


* Operating Systems are hard to test but need to be thoroughly tested due to lots of upstream changes.
* openSUSE have developed openQA in order to test their OSes:
  * Uses mouse & keyboard to interact (like a user would).
  * "Reads" screen using OpenCV.
  * Does graphical testing (like [Wraith][wraith]) and testing of console outputs.
  * Provides screenshots, videos and HDD images for bug reproduction.
  * Provides good visual reporting in the form of dashboards.
  * Runs using VNC against VMs or real devices.
* openQA is used by openSUSE TumbleWeed (which releases every 3-4 days when it passes ~400 test cases) as well as by openSUSE Leap and Red Hat.


*My thoughts: I thought this talk would be interesting as I've been working on a lot of QA stuff at LBG but it was quite specific to OS testing.
Their test runner is quite clever as they test against lots of differing Architectures and setups but the tests themselves are roughly on par with Wraith (image diffing)*


**TL;DR: Operating Systems have tests too.**


## [Continuous Delivery with Docker][docker] by Christoph Lucas - a consultant at Pingworks


* Just like a regular CI pipeline except your build step produces a docker image (analogous to a jar file) which is then hosted in a private docker registry (analogous to nexus).
* Removes the need for Chef, Puppet or Ansible to setup your servers - all you need is Docker.
* You can also build in Docker on Jenkins (using a docker image with all the build tools bundled) rather than installing the build tools on your build slaves.
  * Then extract the built artefact to a new docker image for deployment.
* Can use kubernetes as container runner for hosting the resulting image for acceptance tests.
* Docker isn't all bells and whistles though - you can have security issues e.g. from uncontrolled upstream docker images.


*My thoughts: It sounds like it would be reasonably easy to convert from an existing CI pipeline to one that uses Docker.
The main benefits would be ease of setting up new servers and updating existing runtime environments.
Downsides are security and Docker images being big.*


**TL;DR: Docker is really cool.**


## [When Devops Goes Wrong... Part II][wrong] by David Stanley - Head of Reliability at Trainline


* Issues from part one last year:
  * Monitoring.
  * Deployment.
  * People on call.
* Automation breeds automation:
  * Infrastructure as code is code too.
  * Make sure that it's reviewed and tested.
  * Also that you have frequent deployments and a rollback plan.
* With great power comes great responsibility:
  * Always think before you act - changes (e.g. deletion) in IaaS can happen very quickly.
  * Governance can be a good addition to prevent some production issues.
  * Have lots of redundancy too.
* People, process and tech:
  * Invest in existing people rather than hiring expensive contractors with desired skills.
  * Prioritise goals correctly.


*My thoughts: Trainline seem to have a really modern stack and are fairly agile.
None of these points were totally revelationary but they were still good to think about.*


**TL;DR: Things go wrong in Tech.
People are difficult (again).**


## [Zero to Continuous Delivery on the Cloud][zero] by James Heggs - a consultant at CLOS Consultancy


* James also runs the Manchester Devops meetups
* Talked a bit about Google cloud platform:
  * Very similar to AWS except resources are organised by project.
  * Google Container Engine is roughly kubernetes.
* Kubernetes is for automating deployment, scaling and container management.
Their terminology is as follows:
  * Cluster - set of machines used to run the containers.
  * Node - an individual machine where pods can be deployed.
  * Pod - co-located group of containers.
  * Service - defines a set of pods and a way of accessing them e.g. IP address.
* He then showed a demo which can be found [here][zero-demo-blog] and  [here][zero-demo-code]


*My thoughts: You can make some really nifty stuff with Docker and Kubernetes.
I should probably go to more meetups as well.*


**TL;DR: Docker and Kubernetes are really cool.**


## [API Testing as Part of Your CI Pipeline][api] by Jason Smith - Senior Developer at Container Solutions


* Interface Description Languages are a good idea:
  * Precise
  * Representation Independent
  * Language Independent
  * Maintainable
* For APIs, SOAP wasn't great generally but WSDL was a good idea.
* REST isn't really standardised.
* OpenAPI specification (formerly Swagger) solves the problem.
Alternatives are API Blueprint and RAML.
* Showed an OpenAPI example [here][openapi].
* The Swagger editor and UI seem useful.
* [Dredd][dredd] takes your YAML OpenAPI spec and tests that your API implementation conforms.
* [Pokemock][pokemock] takes your YAML OpenAPI spec and provides a mock implementation of it
([Drakov][drakov] is a mock server which uses API Blueprint specifications.)


*My thoughts: I've used Swagger before but only for generating documentation for an API.
Specifications, and the tests and mocks that you can create from them, sound useful if you've got an API consumer building their app at the same time as you build the API.*


**TL;DR: You should use API specifications if you're building an API.**

[clc]:             https://2017.continuouslifecycle.london/
[openness]:        https://2017.continuouslifecycle.london/sessions/keynote-2/
[serverless]:      https://2017.continuouslifecycle.london/sessions/cicd-in-a-serverless-world/
[serverless-calc]: http://serverlesscalc.com/
[openqa]:          https://2017.continuouslifecycle.london/sessions/openqa-avoiding-disasters-of-biblical-proportions/
[wraith]:          https://github.com/BBC-News/wraith
[docker]:          https://2017.continuouslifecycle.london/sessions/continuous-delivery-with-docker/
[wrong]:           https://2017.continuouslifecycle.london/sessions/when-devops-goes-wrong-part-ii/
[zero]:            https://2017.continuouslifecycle.london/sessions/zero-to-continuous-delivery-on-the-cloud/
[zero-demo-blog]:  https://medium.com/google-cloud/zero-to-continuous-delivery-with-google-cloud-platform-8e3bf1312fb5
[zero-demo-code]:  https://github.com/eggsy84?utf8=%E2%9C%93&tab=repositories&q=gcp&type=&language=
[api]:             https://2017.continuouslifecycle.london/sessions/api-testing-as-part-of-your-ci-pipeline/
[openapi]:         https://github.com/ContainerSolutions/DreddDemo
[dredd]:           https://github.com/apiaryio/dredd
[pokemock]:        https://github.com/mobilcom-debitel/pokemock
[drakov]:          https://github.com/Aconex/drakov