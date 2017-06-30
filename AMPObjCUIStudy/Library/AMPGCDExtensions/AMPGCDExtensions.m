//
//  AMPGCDExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPGCDExtensions.h"

#pragma mark -
#pragma mark Private Declarations

typedef void(^AMPVoidBlock)(void);

dispatch_queue_t AMPQueueWithQOSClass(long identifier);

#pragma mark -
#pragma mark Public Implementation

static char * const kAMPDispatchSerialQueue = "kAMPDispatchSerialQueue";
static char * const kAMPDispatchConcurrentQueue = "kAMPDispatchConcurrentQueue";

dispatch_queue_t AMPCreateDispatchSerialQueue() {
    return dispatch_queue_create(kAMPDispatchSerialQueue, DISPATCH_QUEUE_SERIAL);
}

dispatch_queue_t AMPCreateDispatchConcurrentQueue() {
    return dispatch_queue_create(kAMPDispatchConcurrentQueue, DISPATCH_QUEUE_CONCURRENT);
}

dispatch_queue_t AMPMainQueue() {
    return dispatch_get_main_queue();
}

dispatch_queue_t AMPBackgroundQueue() {
    return AMPQueueWithQOSClass(QOS_CLASS_BACKGROUND);
}

dispatch_queue_t AMPUtilityQueue() {
    return AMPQueueWithQOSClass(QOS_CLASS_UTILITY);
}

dispatch_queue_t AMPDefaultQueue() {
    return AMPQueueWithQOSClass(QOS_CLASS_DEFAULT);
}

dispatch_queue_t AMPUserInitiatedQueue() {
    return AMPQueueWithQOSClass(QOS_CLASS_USER_INITIATED);
}

dispatch_queue_t AMPUserInteractiveQueue() {
    return AMPQueueWithQOSClass(QOS_CLASS_USER_INTERACTIVE);
}

void AMPDispatchAsyncInBackground(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_async(AMPBackgroundQueue(), block);
}

void AMPDispatchSyncInBackground(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_sync(AMPBackgroundQueue(), block);
}

void AMPDispatchAsyncOnQueue(dispatch_queue_t queue, dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_async(queue, block);
}

void AMPDispatchSyncOnQueue(dispatch_queue_t queue, dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_sync(queue, block);
}

void AMPDispatchAfterDelay(uint64_t delay, dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), AMPBackgroundQueue(), block);
}

void AMPDispatchAsyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }

    dispatch_async(dispatch_get_main_queue(), block);
}

void AMPDispatchSyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    if ([[NSThread currentThread] isMainThread]) {
        block();
    } else {
        dispatch_sync(AMPMainQueue(), block);
    }
}

#pragma mark -
#pragma mark Private Implementation

dispatch_queue_t AMPQueueWithQOSClass(long identifier) {
    return dispatch_get_global_queue(identifier, 0);
}
