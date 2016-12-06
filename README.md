# This is project for CSE-535 Asynchronous System

## 1.INSTRUCTIONS

Here is the instructions to build and run your system:

Please run bin/startup.sh. This script makes all source file using Makefile first and then run Master using DistAlgo runtime with parameters such as log location, log level, workload and program configuration file.

The default workload is "workload1". Please run bin/startup.sh [workloadX] for other test cases. By now we have workload1 ~ workload8 which are described in testing.txt.  

For example: To perform functional test which is workload1, please run: bin/startup.sh workload1


## 2.MAIN FILES

Here is the structure and path of our source code file. All core components are in src/comp package.

src/
├── comp
│   ├── application.da : Client side process producing a sequence of requests with specific or random payload according to the configuration.
│   ├── coordinator.da : Coordinator process handling all requests and response in-between Application and Worker.
│   └── worker.da      : Worker process with evaluation engine inside.
├── db                 : Database emulator, record initial file and policy file.
│   ├── db.da
│   ├── stress_test_record.xml
│   ├── stress_test_policy.xml
│   ├── record.xml
│   ├── policy.xml
│   └── policy2.xml    : policy with $subject.ATTRIBUTE and $resource.ATTRIBUTE case. 
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

## 6.Phase 4: MVCC Improvement

### 6.1 Project Structure

We reuse the most of codes in Phase2 and add some new file ending with "mvcc" to represent the file in this phase.

### 6.2 Test Case

For the test case, please refer to testingmvcc.txt. We test all cases mentioned in the requirement.

### 6.2 Performance Evaluation

1) First we perform stress test on old Phase 2 code. After running several times with different params, we observed that:

To handle 1000 request with random payload (5 subjects and 2 resources) and 5 ~ 10 clients, it costs nearly 106s ~ 110s.

2) Then we run test against the new codebase enhanced by MVCC.


