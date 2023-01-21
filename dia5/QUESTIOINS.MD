# Questions Day 5
**1. True or False: we can prevent the heap being erased during upgrades by using a stable heap.**
>R:/ False

**2.A.call() -> B.call() -> C How much time (or rounds of consensus) do we need to wait for an answer?** 
>R:/ It takes around 2 seconds (1 round of consensus), if both canisters are in the same subnet, or 4 seconds (2 round of consensus) if the canister is in another subnet.

**3. Is possible to realize an intercanister call in query mode?**
>R:/ False, intercanister calls can only be realized in update mode