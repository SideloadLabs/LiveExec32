#import <Foundation/Foundation+LC32.h>

@implementation NSPort (LC32SyntheticPort)

/*
 * +[NSPort port] is a generically-bridged 0-arg factory call (see
 * generated.plist), same machinery used successfully by hundreds of other
 * classes -- so a nil result here isn't a marshaling bug, it means the
 * *guest* never gets far enough to hand back a real object, or the class
 * cluster resolution for a bare NSPort factory call misbehaves for this
 * abstract base class specifically. Overriding it directly sidesteps the
 * generic path entirely and guarantees FIFA14's runloop keep-alive thread
 * gets a valid, real host-backed port no matter what.
 */
+ (NSPort *)port {
    return [[[NSMachPort alloc] init] autorelease];
}

@end

@implementation NSMachPort (LC32SyntheticPort)

+ (NSPort *)port {
    return [[[NSMachPort alloc] init] autorelease];
}

/*
 * `machPort` here is a port *name* minted by LC32's own synthetic Mach
 * subsystem (see the "synthetic port" notes in dynarmic_syscalls.cpp) -- it
 * is not a real kernel port right and means nothing to the host kernel that
 * backs this NSMachPort. The generic bridge forwarded it verbatim into the
 * real +[NSMachPort portWithMachPort:], which the host kernel rejects,
 * yielding nil. Old titles that mint a reply/notify port this way (FIFA14's
 * background IPC-heartbeat thread does) only need *some* schedulable port to
 * hand to -[NSRunLoop addPort:forMode:] -- not that specific port identity --
 * so hand back a real, always-valid host-backed port instead of a bogus one.
 */
+ (NSPort *)portWithMachPort:(uint32_t)machPort {
    (void)machPort;
    return [[[NSMachPort alloc] init] autorelease];
}

+ (NSPort *)portWithMachPort:(uint32_t)machPort options:(NSUInteger)options {
    (void)machPort;
    (void)options;
    return [[[NSMachPort alloc] init] autorelease];
}

@end
