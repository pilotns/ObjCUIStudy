//
//  AMPGCDExtensions.h
//  AMPObjCStudy
//
//  Created by pilotns on 25.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AMPSheduledBlock)(BOOL *stop);

dispatch_queue_t AMPCreateDispatchSerialQueue();
dispatch_queue_t AMPCreateDispatchConcurrentQueue();

dispatch_queue_t AMPMainQueue();
dispatch_queue_t AMPBackgroundQueue();
dispatch_queue_t AMPUtilityQueue();
dispatch_queue_t AMPDefaultQueue();
dispatch_queue_t AMPUserInitiatedQueue();
dispatch_queue_t AMPUserInteractiveQueue();

void AMPDispatchAsyncInBackground(dispatch_block_t block);
void AMPDispatchSyncInBackground(dispatch_block_t block);

void AMPDispatchAsyncOnQueue(dispatch_queue_t queue, dispatch_block_t block);
void AMPDispatchSyncOnQueue(dispatch_queue_t queue, dispatch_block_t block);

void AMPDispatchAfterDelay(uint64_t delay, dispatch_block_t block);

void AMPDispatchAsyncOnMainQueue(dispatch_block_t block);
void AMPDispatchSyncOnMainQueue(dispatch_block_t block);

