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
[![Status][status-shield]][pull]

[![Language](https://img.shields.io/badge/language-C++-blue.svg)](https://isocpp.org/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://gitlab.com/doevelopper/cppbdd101/tree/develop)
[![License](https://img.shields.io/badge/license-Apache%20license%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: LGPL v3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](http://www.gnu.org/licenses/lgpl-3.0)

[![pipeline status](https://gitlab.com/doevelopper/cfs-com/badges/master/pipeline.svg)](https://gitlab.com/doevelopper/cfs-com/commits/master)
[![coverage report](https://gitlab.com/doevelopper/cfs-com/badges/master/coverage.svg)](https://gitlab.com/doevelopper/cfs-com/commits/master)

# Data distribution Service and Micro Services for linux applications


# DDS Abstraction Library 
Each DDS implementation can do everything we ask for (and even more), but it will not show you how to achieve that. 
DDS AL Library sits on top of common DDS implementation and do initializes the runtime environment, 
loads the classes, creates the domain participants...
## Introduction

There are a number of different DDS implementations available.
Many project are always DDS-dependent.Unfortunatly , instead of relying
on one implementtaion of DDS (put all our eggs in one basket), it is sometimes 
necessary to use a different implementation. If a huge amount pof code has been alredy developped
DDS abstraction layer helps to have less significant changes.

It aims to use
- [ ]  RTI Connext DDS
- [ ]  PrismTech OpenSplice DDS
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
[status-shield]: https://img.shields.io/docker/status/doevelopper/developmentplatform.svg
[status]: https://img.shields.io/docker/status/doevelopper/developmentplatform.svg
