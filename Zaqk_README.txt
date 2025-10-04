thank you for reading this 
- there are a couple things within the configs that need to be adjusted manually


GameUserSettings:
the only things that may need to be adjusted in here are
FrameRateLimit=999.000000 (I externally cap my fps, but you can change your limit here)
ResolutionSizeX=1920
ResolutionSizeY=1080
LastUserConfirmedResolutionSizeX=1920
LastUserConfirmedResolutionSizeY=1080 (if you play at lower resolution)

Engine
r.Streaming.PoolSize=14000 (14000 is set because I have a GPU with 16 gb of vram, adjust according to your gpu.) (6000 for 8gb, 10000 for 12gb etc)

IF YOU ARE USING A HARDDRIVE AND NOT AN SSD
s.MinBulkDataSizeForAsyncLoading=0 set this to s.MinBulkDataSizeForAsyncLoading=64

remove:
s.AsyncLoadingThreadEnabled=1
s.AsyncLoadingTimeLimit=5
s.AsyncLoadingUseFullTimeLimit=1
s.PriorityAsyncLoadingExtraTime=4
s.IoDispatcherCacheSizeMB=1024
s.ContinuouslyIncrementalGCWhileLevelsPendingPurge=1

set both to 0:
r.Streaming.UseFixedPoolSize=1 -> r.Streaming.UseFixedPoolSize=0
r.Streaming.PoolSize=14000 -> r.Streaming.PoolSize=0

set to 15:
r.Streaming.FramesForFullUpdate=6 -> r.Streaming.FramesForFullUpdate=15

set to 8:
r.Streaming.NumStaticComponentsProcessedPerFrame=16 -> r.Streaming.NumStaticComponentsProcessedPerFrame=8