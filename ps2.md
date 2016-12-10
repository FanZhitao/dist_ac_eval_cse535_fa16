
### CSE 535 Asynchronous System Problem Set 2
##### Name: Zhitao Fan, Chen Dai

------------------------------
#### Problem 1: GFS Stale Chunk

--------------------------------------
#### Problem 2: BigTable Tablet Locate

```py

# Global data structure and variables:
# 1) Client cache: <(table,rowkey), (roottbl, metatbl)>
# 2) Chubby location: chubbyLoc

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
        updateCache((table, rowkey), (rootTbl, newMetaTbl))
        return tblId

    # Worst case: stale Metadata and Root tablet location info
    newRootTbl = queryRootTablet(chubbyLoc, table, rowkey)
    if newRootTbl is not None:
        newMetaTbl = queryMetadataTablet(newRootTbl, table, rowkey)
        tblId = queryUserTablet(newMetaTbl, table, rowkey)
        updateCache((table, rowkey), (newRootTbl, newMetaTbl))
        return tblId
    # Raise error if reach here which is impossible unless Chubby is down

def queryRootTablet(chubbyLoc, table, rowkey):
    # Send request to Chubby server directly
    # Don't consider failure of Chubby server
    sendAndWaitForResponse(("queryRootTablet", table, rowkey), to=chubbyLoc)

def queryMetadataTablet(rootTbl, table, rowkey):
    # Client cache is empty, then return None to fill cache
    if rootTbl is None:
        return None

    # Handle tablet server failure
    sendAndWaitForResponse(("queryMetadataTablet", table, rowkey), to=rootTbl)
    if timeout without reply:
        return None    

def queryUserTablet():
    # Exactly same as queryMetadataTablet()
```

---------------------------------------
#### Problem 3: Megastore Snapshot Read

The paper says: "For a snapshot read, the system picks up the timestamp of the last known fully applied transaction and reads from there, even if some committed transactions have not yet been applied." But for current read, it ensures all committed transactions have been applied before read. Therefore, if a committed transaction is being applied at the moment that snapshot read is performed. The write of that transaction won't be observed by snapshot read.


----------------------
#### Problem 4: Dynamo

(a) When a node (say X) is being removed from the system, all its tokens will be removed from the ring. For every key range that is assigned to node X, there may be a number of nodes (less than or qeual to N) that will be in charge of halding keys that fall within its token range. Due to the allocation of key ranges to X, some other nodes will be responsible for some of the keys and X transfers those keys to these nodes.

In the case of planned removal of a node, the removing node can immediately send appropriate set of key range to corresponding node which will be in charge. If a node is down due to an unexpected failure, related nodes do not discover it until they confirm the node fails to respond to a message. In addition, they need to query the key ranges to N nodes to confirm the new range they will be in charge.

(b) Let us consider the scenario where token X0 is being removed from the ring shown in Figure 2 between A and B. It is in charge of storing keys in the ranges (F, G], (G, A] and (A, X]. As a consequence, nodes B, C, and D need to store the keys in these respective ranges after X is removed. Therefore, X will offer to and upon confirmation from B, C, and D the appropriate set of keys. Then X0 can be removed. We can follow these steps to remove rest tokens of X one by one.

Key ranges that are newly assigned to B, C, and D:
(F, G] --> B,
(G, A] --> C,
(A, X] --> D.