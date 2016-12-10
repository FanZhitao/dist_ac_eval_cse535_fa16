
### CSE 535 Asynchronous System Problem Set 2
##### Name: Zhitao Fan, Chen Dai

------------------------------
#### Problem 1: GFS Stale Chunk

If a secondary misses a mutation, the primary will notice it because only when all the secondaries reply to the primary indicates they have completed the operation. Then the primary replies to the client with the error encountered. The modified region is left in an inconsistent state. The client code handles such errors by retrying the failed mutation. It will make a few attempts before reading a chuck from such a secondary.

--------------------------------------
#### Problem 2: BigTable Tablet Locate

```py
# Global data structure and variables:
# 1) Client cache: cache=<(table,rowkey), (roottbl, metatbl)>
# 2) Chubby location: chubbyLoc="chubby://ip:port"

def locateTablet(table, rowkey):
    # Traverse cached location from bottom up.
    # And refresh cache if stale from top down.
    rootTbl, metaTbl = checkCache(table, rowkey)

    # Best case: Up-to-date cache
    tblId = queryUserTablet(metaTbl, table, rowkey)
    if tblId is not None: # client cache works!
        return tblId
    
    # Stale Metadata tablet location info
    newMetaTbl = queryMetadataTablet(rootTbl, table, rowkey)
    if newMetaTbl is not None:
        tblId = queryUserTablet(newMetaTbl, table, rowkey)
        if tblId is not None:
            updateCache((table, rowkey), (rootTbl, newMetaTbl))
            return tblId

    # Stale Metadata and Root tablet location info or Empty cache
    newRootTbl = queryRootTablet(chubbyLoc, table, rowkey)
    if newRootTbl is not None:
        newMetaTbl = queryMetadataTablet(newRootTbl, table, rowkey)
        tblId = queryUserTablet(newMetaTbl, table, rowkey)
        updateCache((table, rowkey), (newRootTbl, newMetaTbl))
        return tblId
    # Raise error if reach here which is impossible unless Chubby is stale

def checkCache(table, rowkey):
    return cache[(table, rowkey)]

def updateCache(key, value):
    cache[key] = value

def queryRootTablet(chubbyLoc, table, rowkey):
    # Send request to Chubby server directly
    # Don't consider failure of Chubby server
    return sendAndWaitForResponse(("queryRootTablet", table, rowkey), to=chubbyLoc)

def queryMetadataTablet(rootTbl, table, rowkey):
    # Client cache is empty, then return None to fill cache
    if rootTbl is None:
        return None

    # Handle tablet server failure
    resp = sendAndWaitForResponse(("queryMetadataTablet", table, rowkey), to=rootTbl)

    # Return None if failure or tablet being moved elsewhere
    if timeout without reply or resp is invalid:
        return None
    return resp

def queryUserTablet(metaTbl, table, rowkey):
    # Exactly same as queryMetadataTablet()
    if metaTbl is None:
        return None
    resp = sendAndWaitForResponse(("queryUserTablet", table, rowkey), to=metaTbl)
    if timeout without reply or resp is invalid:
        return None
    return resp
```

---------------------------------------
#### Problem 3: Megastore Snapshot Read

The paper says: "For a snapshot read, the system picks up the timestamp of the last known fully applied transaction and reads from there, even if some committed transactions have not yet been applied." But for current read, the coordinator provides up-to-date view across the data centers and all committed transactions are guaranteed to have been applied by catch-up mechanism before read. Therefore correspondingly if a committed transaction is being applied at the moment that snapshot read is performed or even the transaction is not accepted by the replica of the data center that snapshot read is working on. The write of that transaction won't be observed by snapshot read obviously. 

----------------------
#### Problem 4: Dynamo

(a) When a node (say X) is being removed from the system, all its tokens will be removed from the ring. For every key range that is assigned to node X, there may be a number of nodes (less than or qeual to N) that will be in charge of halding keys that fall within its token range. Due to the allocation of key ranges to X, some other nodes will be responsible for some of the keys and X transfers those keys to these nodes.

In the case of planned removal of a node, the removing node can immediately send appropriate set of key range to corresponding node which will be in charge. If a node is down due to an unexpected failure, related nodes do not discover it until they confirm the node fails to respond to a message. In addition, they need to query the key ranges to N nodes to confirm the new range they will be in charge.

(b) Let us consider the scenario where token X0 is being removed from the ring shown in following figure between A and B. It is in charge of storing keys in the ranges (F, G], (G, A] and (A, X]. As a consequence, nodes B, C, and D need to store the keys in these respective ranges after X is removed. Therefore, X will offer to and upon confirmation from B, C, and D the appropriate set of keys. Then X0 can be removed. We can follow these steps to remove rest tokens of X one by one.

         ...A...
     ....       ..X.
   G.               .B
  .                   .
 .                     .
 .                     .
F                       .
.                       C
 .                     .
 .                    .
  .                  .
   E.              .D
     ....       ...
         .......


Key ranges that are newly assigned to B, C, and D:
(F, G] --> B,
(G, A] --> C,
(A, X] --> D.
