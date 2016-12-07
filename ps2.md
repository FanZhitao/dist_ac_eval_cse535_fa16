
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