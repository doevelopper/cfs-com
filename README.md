<!--
       cfs-com/README.md

              Copyright (c) 2014-2018 A.H.L

       Permission is hereby granted, free of charge, to any person obtaining
       a copy of this software and associated documentation files (the
       "Software"), to deal in the Software without restriction, including
       without limitation the rights to use, copy, modify, merge, publish,
       distribute, sublicense, and/or sell copies of the Software, and to
       permit persons to whom the Software is furnished to do so, subject to
       the following conditions:

       The above copyright notice and this permission notice shall be
       included in all copies or substantial portions of the Software.

       THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
       EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
       MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
       NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
       LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
       OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-->


```txt
 __          __            __
/   _  _ _  |_|. _ |_ |_  (_    _|_ _ _
\__(_)| (-  | ||(_)| )|_  __)\/_)|_(-|||
                _/           /
 __
/   _  _  _     _ . _ _ |_. _  _    /\ |_  _|_ _ _  _|_. _  _   |   _    _ _
\__(_)|||||||_|| )|(_(_||_|(_)| )  /--\|_)_)|_| (_|(_|_|(_)| )  |__(_|\/(-| .
                                                                      /
```
[![Docker Pulls][pull-shield]][pull]
[![Automation][automated-shield]][pull]

[![Language][CPP-shield]][CPP]
[![Maintenance][Maintenance-shield]][Main-tenance]

[![Python][Python-version-shield]][Python-version]
[![language][CPP-14-shield]][CPP-14]
[![license][MIT-license-shield]][MIT-license]

[![Master pipeline][pipeline-status-shield]][pipeline-status]
[![Coverage report][pipeline-status-shield]][pipeline-status]

[![Ubuntu 18.04 package][ubuntu-18-10-shield]][ubuntu-18-10]
 </br>

# Data distribution Service and Micro Services for linux applications

Branch   | Gitlab-CI | Travis | Build |  Tests  | Integration Test | Coverage | Documentation |
|--------|-----------|--------|-------|---------|------------------|----------|---------------|
|[__master__][cfs-master] | [![pipeline status][cfs-master-shield]][cfs-master] |-|-|-|-|[![coverage report][cfs-cov-master-shield]][cfs-master-shield]| ![tbd](https://img.shields.io/badge/development%20status-active-green.svg)
|[__develop__][cfs-develop] | [![pipeline status][cfs-develop-shield]][cfs-develop] |-|-|-|-| [![coverage report][cfs-cov-develop-shield]][cfs-develop-shield]|
|[__release__][cfs-release]


# DDS Abstraction Library
Each DDS implementation can do everything we ask for (and even more), but it will not show you how to achieve that.
DDS AL Library sits on top of common DDS implementation and do initializes the runtime environment,
loads the classes, creates the domain participants...

Todo
----

* [ ] :volcano: RTI Shapes Demo of OMG's Data Distribution Service (DDS): OpenDDS, OpenSplice and Fast RTPS
* [ ] :feet: CI script covering many cloud ci and local storage ci solutions
* [ ] :skull: Provide custom script for runing static coverage analysis tools
* [ ] :fu: Provide ability to generate specifications from code sources
* [ ] :ok_hand: Provide seamless integration with common IDE CLion/Eclipse-cdt/Netbeans...
* [ ] :point_up_2: Define a version number inside CMake and print it to the output of the executable.
* [ ] :point_right: Print the Git hash to the output of the executable.
* [ ] :star: Create an installer so the program can be installed properly (GNU standards).
* [ ] :pill: Create a DEB or RPM package (if relevant for your distribution).
* [ ] :zzz: More specific FAQ and Troubleshooting help
* [ ] :cyclone: C++11/14/17 Features
* [ ] :alien: Design patterns lectures
* [ ] :trollface: Offuscated c++ snippets...

Artifactory binaries distribution management
--------------------------------------------

| Distribution  Chanel         | Description                                                                                                                                                                                   |
|------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| :bangbang: [__Nightly__](#www.tbd.acme) | Builds created out of the central repository every night, packaged up every night for bleeding-edge testers to install and test.These are not qualified by QA.                                                                                                      |
| :heavy_exclamation_mark: [__Aurora__](#www.tbd.acme) | Builds created out of the aurora repository, which is synced from central repository every weeks.There is a small amount of QA at the start of the 1 week period before the updates are offered.as such its status is roughly "experimental".  |
| :interrobang: [__Beta__](#www.tbd.acme)  | Builds created out of the master repository, qualified by QA as being of sufficient quality to release to beta users.                                                                         |
| :heavy_check_mark: [__Release__](#www.tbd.acme) | Builds created out of the release repository, qualified by QA as being of sufficient quality to release to hundreds of millions of people.

## Introduction

There are a number of different DDS implementations available.
Many project are always DDS-dependent.Unfortunatly , instead of relying
on one implementtaion of DDS (put all our eggs in one basket), it is sometimes
necessary to use a different implementation. If a huge amount pof code has been alredy developped
DDS abstraction layer helps to have less significant changes.

It aims to use
- [ ]  RTI Connext DDS
- [ ]  PrismTech OpenSplice DDS (cyclonedds ???)
- [ ]  OpenDDS
- [ ]  Twin Oaks Computing CoreDX DDS
- [ ]  eProsima Fast-RTPS

by providing

- Creating Topics in Partitions of the GDS (Global Data Space)
- Subscribing to these Topics via Listeners (and of course via DataReader instances)
- Publishing Events to these Topics via a DataWriter instance
- Handling QoS
- Handling Security
- Single host DDS communication
- Multi host DDS communication

## Requirements

### Dependencies

#### Docker
    Docker docker-compose available on the system to build container for developpement
    and images to be deployed on K8S.
    Images are build from a common base:

```txt
    registry.gitlab.com/doevelopper/cfs-com
    or
    docker.io/doevelopper/cfs-com
    or
    acme-techs.freeboxos.fr/doevelopper/cfs-com
```
Unless RTI images, others contais JAVA , gRPC, protocobufer, QT 5.13 supports
Wireshark for sniffing packet  (OpendDDs Dissector for eg)

#### Chose one of below containers to build, test,tets coverage..

    registry.gitlab.com/doevelopper/cfs-com/Opendds-dev
    registry.gitlab.com/doevelopper/cfs-com/vortex-dev
    registry.gitlab.com/doevelopper/cfs-com/fats-rtps-dev
    registry.gitlab.com/doevelopper/cfs-com/rti-dev

####  ...and deploy DDs application on

    registry.gitlab.com/doevelopper/cfs-com/Opendds-deploy
    registry.gitlab.com/doevelopper/cfs-com/vortex-deploy
    registry.gitlab.com/doevelopper/cfs-com/fats-rtps-deploy
    registry.gitlab.com/doevelopper/cfs-com/rti-deploy


## Interactive Data Language


##  Domain Participant Factory


## Domain participant


## Type registration


## Topic


## Content Filtered Topic

## Publisher


## Subscriber

## Data Writer

### Interface

### Generic interface

### Specific interface

## Data Reader

### Interface

### Generic interface

### Specific interface

## Exemple

### Instance Registration

### Write

### Reada

## Xml Object Over DDS

## Data Reader Callbacks

### Read Condition

### Wait Set

### Synchronous Callback Manager

### Data Callback Listener

### Data Callback Data Reader

#Disclaimer
Of course, as it is only an abstraction (and we're not stating that we would've created a better solution
for the problem than Vortex itself) it can do way less than what the OpenSplice DDS is capable of,
but for what we need it, it is perfect.

### Software licences
Copyright © 2014 - 2018 A.H.L , Inc. All Rights Reserved.
Copyright the authors and contributors. See individual source files
for details.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 SUCH DAMAGE.

- Code and documentation copyright 2011-2018 A.H.L, Inc.
- Code are released under [![License][apache-license-shield]][apache-license]
- Docs are released under [![License: CC BY-NC-SA 4.0][BY-NC-SA-4.0-shield]][BY-NC-SA-4.0]
- CI/CD Scripts are under [![License: LGPL v3][LGPL-v3-shield]][LGPL-v3]

## Contact

---

> Portal [acme](https://www.tbd.acme) &nbsp;&middot;&nbsp;
> GitHub [@doevelopper](https://github.com/doevelopper) &nbsp;&middot;&nbsp;
> Twitter [@doevelopper](https://twitter.com/doevelopper)


[LGPL-v3-shield]: https://img.shields.io/badge/License-LGPL%20v3-blue.svg
[LGPL-v3]: http://www.gnu.org/licenses/lgpl-3.0
[BY-NC-SA-4.0-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
[BY-NC-SA-4.0]: https://creativecommons.org/licenses/by-nc-sa/4.0/
[apache-license-shield]: https://img.shields.io/badge/license-Apache%20license%202.0-blue.svg
[apache-license]: https://opensource.org/licenses/Apache-2.0
[pull-shield]: https://img.shields.io/docker/pulls/doevelopper/developmentplatform.svg
[pull]: https://github.com/doevelopper/cfs-com/tree/master
[automated-shield]: https://img.shields.io/docker/automated/doevelopper/developmentplatform.svg
[automated]: https://img.shields.io/docker/automated/doevelopper/developmentplatform.svg
[ubuntu-18-10-shield]: https://repology.org/badge/version-for-repo/ubuntu_18_04/cpprestsdk.svg
[ubuntu-18-10]: https://github.com/doevelopper/cfs-com/tree/master
[CPP-shield]: https://img.shields.io/badge/language-C++-blue.svg
[CPP]: https://isocpp.org/
[CPP-14-shield]: https://img.shields.io/badge/language-C%2B%2B14-red.svg
[CPP-14]: https://en.wikipedia.org/wiki/C%2B%2B14
[Python-version-shield]: https://img.shields.io/pypi/pyversions/cpplint.svg
[Python-version]: https://www.python.org/
[MIT-license-shield]: https://img.shields.io/badge/license-MIT-blue.svg
[MIT-license]: https://en.wikipedia.org/wiki/MIT_License
[Maintenance-shield]: https://img.shields.io/badge/Maintained%3F-yes-green.svg
[Main-tenance]: https://gitlab.com/doevelopper/cppbdd101/tree/develop
[pipeline-status-shield]: https://gitlab.com/doevelopper/cfs-com/badges/master/pipeline.svg
[pipeline-status]: https://gitlab.com/doevelopper/cfs-com/commits/master
[coverage-report-shield]: https://gitlab.com/doevelopper/cfs-com/badges/master/coverage.svg
[coverage-report]: https://gitlab.com/doevelopper/cfs-com/commits/master

[cfs-master-shield]: https://gitlab.com/doevelopper/cfs-com/badges/master/pipeline.svg
[cfs-develop-shield]: https://gitlab.com/doevelopper/cfs-com/badges/develop/pipeline.svg
[cfs-release-shield]: https://gitlab.com/doevelopper/cfs-com/badges/release/pipeline.svg
[cfs-cov-master-shield]: https://gitlab.com/doevelopper/cfs-com/badges/master/coverage.svg
[cfs-cov-develop-shield]: https://gitlab.com/doevelopper/cfs-com/badges/develop/pipeline.svg
[cfs-cov-release-shield]: https://gitlab.com/doevelopper/cfs-com/badges/release/pipeline.svg
[cfs-master]: https://gitlab.com/doevelopper/cfs-com/tree/master
[cfs-develop]: https://gitlab.com/doevelopper/cfs-com/tree/develop
[cfs-release]: https://gitlab.com/doevelopper/cfs-com/tree/release


