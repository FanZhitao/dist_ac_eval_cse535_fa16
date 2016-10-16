# This is project for CSE-535 Asynchronous System

## 1.INSTRUCTIONS

Here is the instructions to build and run your system:

Please run bin/startup.sh. This script makes all source file using Makefile first and then run Master using DistAlgo runtime with parameters such as log location, log level, workload and program configuration file.

The default workload is "workload1". Please run bin/startup.sh [workloadX] for other test cases. By now we have workload1 ~ workload5 which are described in testing.txt.  

For example: To perform stress test which is workload5, please run: bin/startup.sh workload5


## 2.MAIN FILES

Here is the structure and path of our source code file. All core components are in src/comp package.

src/
├── comp
│   ├── application.da : Client side process producing a sequence of requests with specific or random payload according to the configuration.
│   ├── coordinator.da : Coordinator process handling all requests and response in-between Application and Worker.
│   └── worker.da      : Worker process with evaluation engine inside.
├── db                 : Database emulator, record initial file and policy file.
│   ├── db.da
│   ├── record.xml
│   └── policy.xml
├── master.da          : The bootstrap process which read configuration file and start up all other processes to make whole system ready for test.
├── msg                : All request and response class. EvalReq/Resp and CommitReq/Resp inherit from base class Request/Response.
│   ├── commitreq.da
│   ├── commitresp.da
│   ├── evalreq.da
│   ├── evalresp.da
│   ├── request.da
│   └── response.da
├── state              : Helper class for coordinator which is responsible for the state management and transition in Cache and StateMachine.
│   ├── admin.da
│   ├── cache.da
│   └── statemac.da
└── util               : Utility class such as global ID generator and router which assigns Coordinator role.
    ├── idgen.da
    └── router.da


## 3.BUGS AND LIMITATIONS

a list of all known bugs in and limitations of your code.

1.Currently we assume data commit to database is guaranteed to succeed to avoid additional ACK message or retry mechanism.
2.For subsequent and dependent request check, part of state info in Admin never clean up which could introduce a GC in future.


## 4.CONTRIBUTIONS  

Here is the list of contributions of our each team member to the current submission.

Chen Dai: 
    1.Code structure and utility preparation.
    2.Master, Application, Subject Coordinator.

Zhitao Fan: 
    1.Resource Coordinator, Worker and Database emulator.
    2.Policy file and test data preparation.


## 5.OTHER COMMENTS

We follow the official naming convention: https://www.python.org/dev/peps/pep-0008/
