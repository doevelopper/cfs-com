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
