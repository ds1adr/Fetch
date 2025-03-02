# Fetch

### Screenshot
![screenshot](https://github.com/user-attachments/assets/95064fd1-1f67-4cf0-845d-d662a9786309)


### Focus Area
1. Network layer for scailability. (Routing protocol, network service and network manager)
2. Protocol for dependency injection

### Time Spent: not exact but 5~6 hours.

### Trade-off
I tried to use core data for image disk cache, but I thought it would be better to maintain dictionary to get cache path, not predicate for search.

### Weakest part
1. Disk cache for images:
    - Need to clean up logic (for instance, LRU cache
    - There is no Memory Cache rignt now, need to add smaller size of memory cache than disk cache.
